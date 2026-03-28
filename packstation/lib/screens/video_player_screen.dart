
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../providers/providers.dart';
import '../services/export_service.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final Session session;

  const VideoPlayerScreen({super.key, required this.session});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  List<SessionTag> _tags = [];

  @override
  void initState() {
    super.initState();
    _initVideo();
    _loadTags();
  }

  Future<void> _initVideo() async {
    if (widget.session.videoPath != null) {
      final file = File(widget.session.videoPath!);
      if (await file.exists()) {
        _controller = VideoPlayerController.file(file);
        await _controller.initialize();
        if (mounted) {
          setState(() {
            _initialized = true;
          });
        }
      }
    }
  }

  Future<void> _loadTags() async {
    final db = ref.read(databaseProvider);
    final tags = await db.getTagsForSession(widget.session.id);
    if (mounted) {
      setState(() {
        _tags = tags;
      });
    }
  }

  @override
  void dispose() {
    if (_initialized) {
      _controller.dispose();
    }
    super.dispose();
  }


  Future<void> _exportSession() async {
    // Show loading
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preparing export...')),
    );

    final exportService = ExportService();
    final path = await exportService.exportSession(session: widget.session, tags: _tags);
    
    if (!mounted) return;
    if (path != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to $path')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Export cancelled or failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session ${widget.session.createdAt}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export',
            onPressed: _exportSession,
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Player
          AspectRatio(
            aspectRatio: _initialized ? _controller.value.aspectRatio : 16 / 9,
            child: Container(
              color: Colors.black,
              child: _initialized
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_controller),
                        VideoProgressIndicator(_controller, allowScrubbing: true),
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            iconSize: 50,
                            icon: Icon(
                              _controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          
          // Details & Tags
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDetailRow('Duration', '${widget.session.durationSeconds}s'),
                _buildDetailRow('Path', widget.session.videoPath ?? 'N/A'),
                const Divider(),
                const Text('Scanned Tags:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                if (_tags.isEmpty)
                  const Text('No tags scanned in this session.')
                else
                  ..._tags.map((tag) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.qr_code),
                          title: Text(tag.barcodeContent),
                          subtitle: Text(tag.scannedAt.toString()),
                        ),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 80, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
