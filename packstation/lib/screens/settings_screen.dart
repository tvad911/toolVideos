
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import '../providers/providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  List<CameraDescription> _cameras = [];
  List<String> _ports = [];
  
  bool _isLoading = true;
  int? _selectedCameraIndex;
  String? _selectedPort;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    final cameraService = ref.read(cameraServiceProvider);
    final scaleService = ref.read(scaleServiceProvider);

    await cameraService.initialize();
    final cams = cameraService.cameras;
    final ports = scaleService.getAvailablePorts();

    if (mounted) {
      setState(() {
        _cameras = cams;
        _ports = ports;
        _isLoading = false;
        // In a real app, we would load saved preferences here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionHeader('Camera'),
                if (_cameras.isEmpty)
                  const Text('No cameras found')
                else
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Select Camera',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCameraIndex,
                    items: List.generate(_cameras.length, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text('${_cameras[index].name} (${_cameras[index].lensDirection})'),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _selectedCameraIndex = value;
                      });
                      // TODO: Save preference
                    },
                  ),
                
                const SizedBox(height: 24),
                
                _buildSectionHeader('Digital Scale'),
                if (_ports.isEmpty)
                  const Text('No serial ports found')
                else
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select Serial Port',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPort,
                    items: _ports.map((port) {
                      return DropdownMenuItem(
                        value: port,
                        child: Text(port),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPort = value;
                      });
                      // TODO: Save preference
                    },
                  ),
                  
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _selectedPort == null ? null : () async {
                    final scaleService = ref.read(scaleServiceProvider);
                    final connected = await scaleService.connect(_selectedPort!);
                    if (!mounted) return;
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(connected ? 'Connected to scale!' : 'Failed to connect')),
                    );
                  },
                  child: const Text('Connect Scale'),
                ),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
