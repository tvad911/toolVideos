import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Service for managing FFmpeg recording processes
class FFmpegService {
  Process? _recordingProcess;
  bool _isRecording = false;
  
  bool get isRecording => _isRecording;

  /// Detect available hardware acceleration
  Future<String> detectHardwareAcceleration() async {
    try {
      // Check for Intel QuickSync (QSV)
      if (await _hasQSV()) {
        debugPrint('FFmpeg: Intel QuickSync detected');
        return 'h264_qsv';
      }
      
      // Check for NVIDIA NVENC
      if (await _hasNVENC()) {
        debugPrint('FFmpeg: NVIDIA NVENC detected');
        return 'h264_nvenc';
      }
      
      // Fallback to CPU encoding
      debugPrint('FFmpeg: Using CPU encoding (libx264)');
      return 'libx264';
    } catch (e) {
      debugPrint('FFmpeg: Error detecting hardware acceleration: $e');
      return 'libx264';
    }
  }

  Future<bool> _hasQSV() async {
    try {
      final result = await Process.run('ffmpeg', ['-encoders']);
      return result.stdout.toString().contains('h264_qsv');
    } catch (e) {
      return false;
    }
  }

  Future<bool> _hasNVENC() async {
    try {
      final result = await Process.run('ffmpeg', ['-encoders']);
      return result.stdout.toString().contains('h264_nvenc');
    } catch (e) {
      return false;
    }
  }

  /// Check if FFmpeg is installed
  Future<bool> checkFFmpegInstalled() async {
    try {
      final result = await Process.run('ffmpeg', ['-version']);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  /// Start recording with multi-camera support
  /// 
  /// [cameraDevices] - List of camera device paths (e.g., /dev/video0, /dev/video1)
  /// [outputPath] - Output video file path
  /// [sessionId] - Session ID for watermark
  /// [watermarkText] - Custom watermark text
  /// [layout] - 'pip' for Picture-in-Picture or 'grid' for grid layout
  Future<bool> startRecording({
    required List<String> cameraDevices,
    required String outputPath,
    required String sessionId,
    String watermarkText = '',
    String layout = 'pip',
  }) async {
    if (_isRecording) {
      debugPrint('FFmpeg: Already recording');
      return false;
    }

    try {
      final codec = await detectHardwareAcceleration();
      final args = await _buildFFmpegCommand(
        cameraDevices: cameraDevices,
        outputPath: outputPath,
        sessionId: sessionId,
        watermarkText: watermarkText,
        codec: codec,
        layout: layout,
      );

      debugPrint('FFmpeg: Starting recording with command: ffmpeg ${args.join(' ')}');
      
      _recordingProcess = await Process.start('ffmpeg', args);
      _isRecording = true;

      // Listen to stderr for FFmpeg output
      _recordingProcess!.stderr.transform(const SystemEncoding().decoder).listen((data) {
        debugPrint('FFmpeg: $data');
      });

      return true;
    } catch (e) {
      debugPrint('FFmpeg: Error starting recording: $e');
      return false;
    }
  }

  /// Stop the current recording
  Future<void> stopRecording() async {
    if (!_isRecording || _recordingProcess == null) {
      return;
    }

    try {
      // Send 'q' to gracefully stop FFmpeg
      _recordingProcess!.stdin.write('q');
      await _recordingProcess!.stdin.flush();
      await _recordingProcess!.stdin.close();
      
      // Wait for process to exit
      await _recordingProcess!.exitCode.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          _recordingProcess!.kill();
          return -1;
        },
      );
      
      _recordingProcess = null;
      _isRecording = false;
      debugPrint('FFmpeg: Recording stopped');
    } catch (e) {
      debugPrint('FFmpeg: Error stopping recording: $e');
      _recordingProcess?.kill();
      _recordingProcess = null;
      _isRecording = false;
    }
  }

  /// Capture thumbnail from video file
  Future<bool> captureThumbnail({
    required String videoPath,
    required String thumbnailPath,
  }) async {
    try {
      final args = [
        '-i', videoPath,
        '-ss', '00:00:01',
        '-vframes', '1',
        '-q:v', '2',
        thumbnailPath,
      ];

      final result = await Process.run('ffmpeg', args);
      return result.exitCode == 0;
    } catch (e) {
      debugPrint('FFmpeg: Error capturing thumbnail: $e');
      return false;
    }
  }

  /// Capture thumbnail from camera device
  Future<bool> captureThumbnailFromCamera({
    required String cameraDevice,
    required String thumbnailPath,
  }) async {
    try {
      final args = Platform.isLinux
          ? [
              '-f', 'v4l2',
              '-i', cameraDevice,
              '-frames:v', '1',
              '-q:v', '2',
              thumbnailPath,
            ]
          : [
              '-f', 'dshow',
              '-i', 'video=$cameraDevice',
              '-frames:v', '1',
              '-q:v', '2',
              thumbnailPath,
            ];

      final result = await Process.run('ffmpeg', args);
      return result.exitCode == 0;
    } catch (e) {
      debugPrint('FFmpeg: Error capturing thumbnail from camera: $e');
      return false;
    }
  }

  Future<List<String>> _buildFFmpegCommand({
    required List<String> cameraDevices,
    required String outputPath,
    required String sessionId,
    required String watermarkText,
    required String codec,
    required String layout,
  }) async {
    final args = <String>[];

    // Input devices
    for (final device in cameraDevices) {
      if (Platform.isLinux) {
        args.addAll(['-f', 'v4l2', '-i', device]);
      } else {
        args.addAll(['-f', 'dshow', '-i', 'video=$device']);
      }
    }

    // Build filter complex based on layout
    String filterComplex;
    if (layout == 'pip' && cameraDevices.length >= 2) {
      // Picture-in-Picture layout
      filterComplex = '''
        [0:v]scale=1920:1080[main];
        [1:v]scale=480:270[pip];
        [main][pip]overlay=W-w-10:10[composed];
        [composed]drawtext=text='$sessionId | %{localtime}':x=10:y=10:fontsize=24:fontcolor=white:box=1:boxcolor=black@0.5[final]
      '''.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' ').trim();
    } else if (layout == 'grid' && cameraDevices.length >= 4) {
      // 2x2 Grid layout
      filterComplex = '''
        [0:v]scale=960:540[v0];
        [1:v]scale=960:540[v1];
        [2:v]scale=960:540[v2];
        [3:v]scale=960:540[v3];
        [v0][v1]hstack[top];
        [v2][v3]hstack[bottom];
        [top][bottom]vstack[composed];
        [composed]drawtext=text='$sessionId | %{localtime}':x=10:y=10:fontsize=24:fontcolor=white:box=1:boxcolor=black@0.5[final]
      '''.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' ').trim();
    } else {
      // Single camera
      filterComplex = '''
        [0:v]scale=1920:1080[scaled];
        [scaled]drawtext=text='$sessionId | %{localtime}':x=10:y=10:fontsize=24:fontcolor=white:box=1:boxcolor=black@0.5[final]
      '''.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' ').trim();
    }

    args.addAll(['-filter_complex', filterComplex]);
    args.addAll(['-map', '[final]']);

    // Encoding settings
    args.addAll(['-c:v', codec]);
    
    if (codec == 'libx264') {
      args.addAll(['-preset', 'ultrafast']);
    } else if (codec == 'h264_qsv') {
      args.addAll(['-preset', 'fast']);
    }

    args.addAll([
      '-b:v', '2M',
      '-maxrate', '2.5M',
      '-bufsize', '4M',
      '-r', '24',
      '-y',
      outputPath,
    ]);

    return args;
  }

  void dispose() {
    if (_isRecording) {
      stopRecording();
    }
  }
}
