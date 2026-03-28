import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await hotKeyManager.unregisterAll();

  runApp(
    const ProviderScope(
      child: PackStationApp(),
    ),
  );
}

class PackStationApp extends StatelessWidget {
  const PackStationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PackStation Recorder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
