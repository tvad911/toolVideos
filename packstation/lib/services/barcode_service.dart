import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service for handling barcode scanner input (HID keyboard mode)
class BarcodeService {
  final StreamController<String> _barcodeController = StreamController<String>.broadcast();
  String _buffer = '';
  Timer? _bufferTimer;
  
  Stream<String> get barcodeStream => _barcodeController.stream;

  /// Initialize barcode scanner listener
  void initialize() {
    debugPrint('BarcodeService: Initialized');
  }

  /// Process keyboard input for barcode scanning
  /// Call this from a KeyboardListener
  void processKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final key = event.logicalKey;
    
    // Check if Enter key (barcode scanner sends Enter at the end)
    if (key == LogicalKeyboardKey.enter) {
      _processBarcodeBuffer();
      return;
    }

    // Add character to buffer
    final char = event.character;
    if (char != null && char.isNotEmpty) {
      _buffer += char;
      
      // Reset timer - if no input for 100ms, assume it's manual typing, not scanner
      _bufferTimer?.cancel();
      _bufferTimer = Timer(const Duration(milliseconds: 100), () {
        // If buffer has content but no Enter received, it might be manual input
        // Clear it to avoid false positives
        if (_buffer.isNotEmpty) {
          debugPrint('BarcodeService: Buffer timeout, clearing: $_buffer');
          _buffer = '';
        }
      });
    }
  }

  void _processBarcodeBuffer() {
    _bufferTimer?.cancel();
    
    if (_buffer.isEmpty) return;
    
    final barcode = _buffer.trim();
    _buffer = '';
    
    // Validate barcode (minimum 5 characters, alphanumeric)
    if (barcode.length >= 5 && _isValidBarcode(barcode)) {
      debugPrint('BarcodeService: Scanned barcode: $barcode');
      _barcodeController.add(barcode);
    } else {
      debugPrint('BarcodeService: Invalid barcode format: $barcode');
    }
  }

  bool _isValidBarcode(String barcode) {
    // Check if barcode contains only alphanumeric characters and common symbols
    return RegExp(r'^[A-Za-z0-9\-_]+$').hasMatch(barcode);
  }

  /// Manually add a barcode (for testing or manual input)
  void addBarcode(String barcode) {
    if (barcode.isNotEmpty && _isValidBarcode(barcode)) {
      _barcodeController.add(barcode);
    }
  }

  void dispose() {
    _bufferTimer?.cancel();
    _barcodeController.close();
  }
}
