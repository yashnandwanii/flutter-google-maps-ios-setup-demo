import 'package:flutter/material.dart';
import 'package:flutter_maps_demo/widgets/pick_location_map.dart';
import 'package:flutter_maps_demo/widgets/read_only_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MapDemoPage(),
    );
  }
}

class MapDemoPage extends StatefulWidget {
  const MapDemoPage({super.key});

  @override
  State<MapDemoPage> createState() => _MapDemoPageState();
}

class _MapDemoPageState extends State<MapDemoPage> {
  double? _selectedLat;
  double? _selectedLng;
  bool _showReadOnlyMap = false;

  void _handleLocationPicked(double lat, double lng) {
    setState(() {
      _selectedLat = lat;
      _selectedLng = lng;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location selected: ${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveLocation() {
    if (_selectedLat != null && _selectedLng != null) {
      setState(() {
        _showReadOnlyMap = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location saved! Scroll down to see the saved location.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location on the map first'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps iOS Integration Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pick a Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap anywhere on the map to select a location. The app will automatically fetch your current location on startup.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            // Interactive Map Widget
            PickLocationMap(
              onLocationPicked: _handleLocationPicked,
            ),
            
            const SizedBox(height: 16),
            
            // Display selected coordinates
            if (_selectedLat != null && _selectedLng != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Coordinates:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Latitude: ${_selectedLat!.toStringAsFixed(6)}'),
                      Text('Longitude: ${_selectedLng!.toStringAsFixed(6)}'),
                    ],
                  ),
                ),
              ),
            
            const SizedBox(height: 16),
            
            // Save button
            ElevatedButton.icon(
              onPressed: _saveLocation,
              icon: const Icon(Icons.save),
              label: const Text('Save Location'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            
            // Show saved location in read-only map
            if (_showReadOnlyMap && _selectedLat != null && _selectedLng != null) ...[
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Saved Location (Read-Only)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This map displays your saved location in a read-only view.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ReadOnlyMap(
                latitude: _selectedLat!,
                longitude: _selectedLng!,
              ),
            ],
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
