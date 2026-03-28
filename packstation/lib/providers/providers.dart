
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/barcode_service.dart';
import '../services/scale_service.dart';
import '../services/camera_service.dart';
import '../database/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final barcodeServiceProvider = Provider<BarcodeService>((ref) {
  final service = BarcodeService();
  service.initialize();
  ref.onDispose(() => service.dispose());
  return service;
});

final scaleServiceProvider = Provider<ScaleService>((ref) {
  final service = ScaleService();
  ref.onDispose(() => service.dispose());
  return service;
});

final cameraServiceProvider = Provider<CameraService>((ref) {
  final service = CameraService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Stream providers for real-time updates
final barcodeStreamProvider = StreamProvider<String>((ref) {
  final service = ref.watch(barcodeServiceProvider);
  return service.barcodeStream;
});

final weightStreamProvider = StreamProvider<double>((ref) {
  final service = ref.watch(scaleServiceProvider);
  return service.weightStream;
});
