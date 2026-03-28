import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:libserialport/libserialport.dart';

/// Service for reading weight data from digital scale via serial port
class ScaleService {
  SerialPort? _port;
  SerialPortReader? _reader;
  final StreamController<double> _weightController = StreamController<double>.broadcast();
  
  Stream<double> get weightStream => _weightController.stream;
  double? _lastWeight;
  
  double? get lastWeight => _lastWeight;

  /// Get list of available serial ports
  List<String> getAvailablePorts() {
    return SerialPort.availablePorts;
  }

  /// Connect to serial port
  /// [portName] - Port name (e.g., 'COM3' on Windows, '/dev/ttyUSB0' on Linux)
  /// [baudRate] - Baud rate (default: 9600)
  Future<bool> connect(String portName, {int baudRate = 9600}) async {
    try {
      _port = SerialPort(portName);
      
      final config = SerialPortConfig();
      config.baudRate = baudRate;
      config.bits = 8;
      config.stopBits = 1;
      config.parity = SerialPortParity.none;
      
      _port!.config = config;
      
      if (!_port!.openReadWrite()) {
        debugPrint('ScaleService: Failed to open port $portName');
        return false;
      }

      debugPrint('ScaleService: Connected to $portName at $baudRate baud');
      
      // Start reading data
      _reader = SerialPortReader(_port!);
      _reader!.stream.listen(_processData, onError: (error) {
        debugPrint('ScaleService: Error reading data: $error');
      });
      
      return true;
    } catch (e) {
      debugPrint('ScaleService: Error connecting to port: $e');
      return false;
    }
  }

  void _processData(Uint8List data) {
    try {
      final text = String.fromCharCodes(data).trim();
      if (text.isEmpty) return;
      
      debugPrint('ScaleService: Raw data: $text');
      
      // Parse weight from common scale formats
      // Example formats:
      // - "ST,GS,+  1.50kg"
      // - "1.50 kg"
      // - "1500g"
      
      final weight = _parseWeight(text);
      if (weight != null) {
        _lastWeight = weight;
        _weightController.add(weight);
        debugPrint('ScaleService: Weight: ${weight}kg');
      }
    } catch (e) {
      debugPrint('ScaleService: Error processing data: $e');
    }
  }

  double? _parseWeight(String text) {
    // Remove common prefixes
    String cleaned = text
        .replaceAll('ST,GS,', '')
        .replaceAll('ST,', '')
        .replaceAll('GS,', '')
        .trim();
    
    // Try to extract number with kg
    RegExp kgPattern = RegExp(r'([+-]?\s*\d+\.?\d*)\s*kg', caseSensitive: false);
    var match = kgPattern.firstMatch(cleaned);
    if (match != null) {
      final value = match.group(1)?.replaceAll(' ', '');
      return double.tryParse(value ?? '');
    }
    
    // Try to extract number with g (convert to kg)
    RegExp gPattern = RegExp(r'([+-]?\s*\d+\.?\d*)\s*g', caseSensitive: false);
    match = gPattern.firstMatch(cleaned);
    if (match != null) {
      final value = match.group(1)?.replaceAll(' ', '');
      final grams = double.tryParse(value ?? '');
      return grams != null ? grams / 1000.0 : null;
    }
    
    // Try to extract just a number (assume kg)
    RegExp numberPattern = RegExp(r'([+-]?\s*\d+\.?\d*)');
    match = numberPattern.firstMatch(cleaned);
    if (match != null) {
      final value = match.group(1)?.replaceAll(' ', '');
      return double.tryParse(value ?? '');
    }
    
    return null;
  }

  /// Disconnect from serial port
  void disconnect() {
    _reader?.close();
    _reader = null;
    _port?.close();
    _port?.dispose();
    _port = null;
    _lastWeight = null;
    debugPrint('ScaleService: Disconnected');
  }

  void dispose() {
    disconnect();
    _weightController.close();
  }
}
