
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../database/database.dart';
import '../providers/providers.dart';
import '../services/ffmpeg_service.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'settings_screen.dart';
import 'library_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WindowListener {
  CameraController? _cameraController;
  bool _isInit = false;
  bool _isRecording = false;
  
  // Session State
  DateTime? _sessionStartTime;
  Timer? _timer;
  String _durationString = "00:00:00";
  final List<String> _sessionBarcodes = [];

  @override
  void initState() {
    super.initState();
    _initCamera();
    // _initScale(); // Initialized via provider or manual connect
    windowManager.addListener(this);
    _registerHotKeys();
  }

  Future<void> _registerHotKeys() async {
    // F9 to seek start/stop recording
    final hotKey = HotKey(
      key: PhysicalKeyboardKey.f9,
      scope: HotKeyScope.system,
    );
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        debugPrint('F9 Pressed');
        if (_cameraController != null && _cameraController!.value.isInitialized) {
            _toggleRecording();
        }
      },
    );
  }

  Future<void> _initCamera() async {
    final cameraService = ref.read(cameraServiceProvider);
    await cameraService.initialize();
    if (cameraService.cameras.isNotEmpty) {
      final controller = await cameraService.getCameraController(0);
      if (mounted && controller != null) {
        setState(() {
          _cameraController = controller;
          _isInit = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    windowManager.removeListener(this);
    hotKeyManager.unregisterAll();
    super.dispose();
  }

  void _startTimer() {
    _sessionStartTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sessionStartTime != null) {
        final duration = DateTime.now().difference(_sessionStartTime!);
        setState(() {
          _durationString = _formatDuration(duration);
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _durationString = "00:00:00";
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _handleBarcode(String barcode) {
    if (_isRecording) {
      _sessionBarcodes.add(barcode);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tag added: $barcode'), duration: const Duration(seconds: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final barcodeAsync = ref.watch(barcodeStreamProvider);
    final weightAsync = ref.watch(weightStreamProvider);

    // Listen to barcode stream side-effects
    ref.listen(barcodeStreamProvider, (previous, next) {
      next.whenData((barcode) => _handleBarcode(barcode));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('PackStation Recorder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_library),
            tooltip: 'Library',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LibraryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: (event) {
          ref.read(barcodeServiceProvider).processKeyEvent(event);
        },
        child: Row(
          children: [
            // Camera Preview Section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                   Container(
                    color: Colors.black,
                    child: Center(
                      child: _isInit && _cameraController != null && _cameraController!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _cameraController!.value.aspectRatio,
                              child: CameraPreview(_cameraController!),
                            )
                          : const Text('No Camera Source', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  if (_isRecording)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.fiber_manual_record, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              _durationString,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Sidebar Section
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.grey.shade800)),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  children: [
                    // Status Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      color: _isRecording ? Colors.red.withValues(alpha: 0.1) : Colors.transparent,
                      child: Column(
                        children: [
                          Icon(
                            Icons.circle,
                            color: _isRecording ? Colors.red : Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isRecording ? 'RECORDING' : 'IDLE',
                            style: TextStyle(
                              color: _isRecording ? Colors.red : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    
                    // Barcode Section
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          _buildInfoCard(
                            context,
                            'Last Scanned',
                            barcodeAsync.when(
                              data: (data) => data,
                              error: (e, _) => 'Error',
                              loading: () => 'Waiting...',
                            ),
                            Icons.qr_code,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoCard(
                            context,
                            'Scale Weight',
                            weightAsync.when(
                              data: (w) => '${w.toStringAsFixed(3)} kg',
                              error: (e, _) => 'Error',
                              loading: () => '0.000 kg',
                            ),
                            Icons.monitor_weight,
                          ),
                          if (_isRecording) ...[
                            const SizedBox(height: 24),
                            Text('Session Tags (${_sessionBarcodes.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            ..._sessionBarcodes.reversed.take(5).map((b) => Text('• $b', style: const TextStyle(fontSize: 12))),
                          ],
                        ],
                      ),
                    ),
                    
                    // Controls
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isRecording ? Colors.red : Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _toggleRecording,
                              icon: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
                              label: Text(_isRecording ? 'STOP RECORDING' : 'START RECORDING'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _toggleRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    if (_isRecording) {
      // STOP RECORDING
      final file = await _cameraController!.stopVideoRecording();
      final endTime = DateTime.now();
      final duration = endTime.difference(_sessionStartTime!);
      
      _stopTimer();
      setState(() => _isRecording = false);
      
      // Move file to permanent storage
      final savedPath = await _moveFileToStorage(file.path, _sessionStartTime!);
      
      // Generate Thumbnail
      String? thumbnailPath;
      try {
        final thumbFile = File('${p.withoutExtension(savedPath)}_thumb.jpg');
        final ffmpeg = FFmpegService(); // Ideally use a provider or singleton
        // Note: For now using ffmpeg process. In production use provider.
        final success = await ffmpeg.captureThumbnail(
          videoPath: savedPath,
          thumbnailPath: thumbFile.path,
        );
        if (success) {
          thumbnailPath = thumbFile.path;
        }
      } catch (e) {
        debugPrint('Error creating thumbnail: $e');
      }

      // Save to DB
      _saveSession(savedPath, thumbnailPath, duration, endTime);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recording saved to $savedPath')),
        );
      }
    } else {
      // START RECORDING
      try {
        await _cameraController!.startVideoRecording();
        _sessionBarcodes.clear();
        _startTimer();
        setState(() {
           _isRecording = true;
        });
      } catch (e) {
        debugPrint('Error starting recording: $e');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<String> _moveFileToStorage(String tempPath, DateTime timestamp) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'session_${timestamp.millisecondsSinceEpoch}.mp4';
    final savedDir = Directory(p.join(appDir.path, 'packstation_recordings'));
    
    if (!await savedDir.exists()) {
      await savedDir.create(recursive: true);
    }
    
    final newPath = p.join(savedDir.path, fileName);
    await File(tempPath).copy(newPath);
    // Optional: delete temp file
    // await File(tempPath).delete(); 
    return newPath;
  }
  
  Future<void> _saveSession(String videoPath, String? thumbnailPath, Duration duration, DateTime endTime) async {
    final db = ref.read(databaseProvider);
    final uuid = const Uuid().v4();
    
    final sessionId = await db.insertSession(
      SessionsCompanion(
        uuid: drift.Value(uuid),
        createdAt: drift.Value(_sessionStartTime!),
        endedAt: drift.Value(endTime),
        durationSeconds: drift.Value(duration.inSeconds),
        videoPath: drift.Value(videoPath),
        thumbnailPath: drift.Value(thumbnailPath),
        // fileSizeMb: drift.Value(fileSize), 
      ),
    );
    // ...

    // Save tags
    for (final barcode in _sessionBarcodes) {
      await db.insertSessionTag(
        SessionTagsCompanion(
          sessionId: drift.Value(sessionId),
          barcodeContent: drift.Value(barcode),
          scannedAt: drift.Value(DateTime.now()), // Ideally we should track scan time
        ),
      );
    }
    
    debugPrint('Session $sessionId saved with ${_sessionBarcodes.length} tags.');
  }

  Widget _buildInfoCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
