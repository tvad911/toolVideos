
import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../database/database.dart';

class ExportService {
  /// Export session data to a ZIP file.
  /// Returns the path of the created ZIP file, or null if cancelled/failed.
  Future<String?> exportSession({
    required Session session,
    required List<SessionTag> tags,
  }) async {
    try {
      // 1. Prepare Metadata
      final metadata = {
        'version': '1.0',
        'session_id': session.uuid,
        'created_at': session.createdAt.toIso8601String(),
        'ended_at': session.endedAt?.toIso8601String(),
        'duration_seconds': session.durationSeconds,
        'tags': tags.map((t) => {
          'barcode': t.barcodeContent,
          'scanned_at': t.scannedAt.toIso8601String(),
          'weight': t.weightAtScan,
        }).toList(),
      };

      // 2. Create Temporary Directory for Zip assembly
      final tempDir = await getTemporaryDirectory();
      final zipDir = Directory(p.join(tempDir.path, 'export_${session.uuid}'));
      if (await zipDir.exists()) {
        await zipDir.delete(recursive: true);
      }
      await zipDir.create();

      // 3. Write Metadata JSON
      final jsonFile = File(p.join(zipDir.path, 'metadata.json'));
      await jsonFile.writeAsString(jsonEncode(metadata));

      // 4. Copy Video
      if (session.videoPath != null) {
        final videoFile = File(session.videoPath!);
        if (await videoFile.exists()) {
          final targetVideo = p.join(zipDir.path, 'video${p.extension(session.videoPath!)}');
          await videoFile.copy(targetVideo);
        }
      }

      // 5. Copy Thumbnail
      if (session.thumbnailPath != null) {
        final thumbFile = File(session.thumbnailPath!);
        if (await thumbFile.exists()) {
          final targetThumb = p.join(zipDir.path, 'thumbnail.jpg');
          await thumbFile.copy(targetThumb);
        }
      }

      // 6. Create Zip File
      // We use the encoder from archive_io
      final zipFilePath = p.join(tempDir.path, 'packstation_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.zip');
      final encoder = ZipFileEncoder();
      encoder.create(zipFilePath);
      await encoder.addDirectory(zipDir);
      encoder.close();

      // 7. Save to User Location (Prompt)
      // On desktop, we can ask user where to save
      String? outputLocation;
      
      // Use FilePicker to save
      final String? result = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Session',
        fileName: p.basename(zipFilePath),
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result != null) {
        final finalFile = File(result);
        await File(zipFilePath).copy(finalFile.path);
        outputLocation = finalFile.path;
      } else {
        // Fallback or Cancelled. If cancelled, we might still want to return zipFilePath if strictly needed,
        // but typically "save file" cancellation means "abort export".
        // Let's assume cancellation.
      }

      // Cleanup
      await zipDir.delete(recursive: true);
      // await File(zipFilePath).delete(); // Keep temp zip? No, delete it.
      if (outputLocation != null) {
        try {
          await File(zipFilePath).delete();
        } catch (_) {}
      }

      return outputLocation;

    } catch (e) {
      debugPrint('Export Error: $e');
      return null;
    }
  }
}
