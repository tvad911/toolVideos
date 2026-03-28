import 'package:camera/camera.dart' as cam;
import 'package:flutter/foundation.dart';

/// Service for managing camera devices
class CameraService {
  List<cam.CameraDescription> _cameras = [];
  final Map<String, cam.CameraController> _controllers = {};
  
  List<cam.CameraDescription> get cameras => _cameras;

  /// Initialize and enumerate available cameras
  Future<bool> initialize() async {
    try {
      _cameras = await cam.availableCameras();
      debugPrint('CameraService: Found ${_cameras.length} cameras');
      for (var i = 0; i < _cameras.length; i++) {
        debugPrint('  Camera $i: ${_cameras[i].name}');
      }
      return _cameras.isNotEmpty;
    } catch (e) {
      debugPrint('CameraService: Error initializing cameras: $e');
      return false;
    }
  }

  /// Get camera controller for a specific camera
  Future<cam.CameraController?> getCameraController(int cameraIndex) async {
    if (cameraIndex >= _cameras.length) {
      debugPrint('CameraService: Invalid camera index $cameraIndex');
      return null;
    }

    final camera = _cameras[cameraIndex];
    final key = camera.name;

    if (_controllers.containsKey(key)) {
      return _controllers[key];
    }

    try {
      final controller = cam.CameraController(
        camera,
        cam.ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();
      _controllers[key] = controller;
      debugPrint('CameraService: Initialized controller for ${camera.name}');
      return controller;
    } catch (e) {
      debugPrint('CameraService: Error creating controller: $e');
      return null;
    }
  }

  /// Get device path for FFmpeg (Linux: /dev/videoX, Windows: camera name)
  String? getCameraDevicePath(int cameraIndex) {
    if (cameraIndex >= _cameras.length) {
      return null;
    }

    final camera = _cameras[cameraIndex];
    
    // On Linux, extract device number from camera name
    if (defaultTargetPlatform == TargetPlatform.linux) {
      // Camera names are typically like "/dev/video0"
      if (camera.name.startsWith('/dev/video')) {
        return camera.name;
      }
      // Fallback: try to extract number
      final match = RegExp(r'(\d+)').firstMatch(camera.name);
      if (match != null) {
        return '/dev/video${match.group(1)}';
      }
      return '/dev/video$cameraIndex';
    }
    
    // On Windows, return the camera name
    return camera.name;
  }

  /// Dispose all camera controllers
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }

  /// Dispose specific camera controller
  void disposeCamera(int cameraIndex) {
    if (cameraIndex >= _cameras.length) return;
    
    final camera = _cameras[cameraIndex];
    final key = camera.name;
    
    if (_controllers.containsKey(key)) {
      _controllers[key]?.dispose();
      _controllers.remove(key);
    }
  }
}
