import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

/// A widget that displays an interactive Google Map allowing users to pick a location.
/// 
/// Features:
/// - Automatically fetches and displays user's current location
/// - Allows users to tap anywhere on the map to select a location
/// - Handles location permissions gracefully
/// - Displays a marker at the selected location
class PickLocationMap extends StatefulWidget {
  final Function(double lat, double lng) onLocationPicked;

  const PickLocationMap({
    super.key,
    required this.onLocationPicked,
  });

  @override
  State<PickLocationMap> createState() => _PickLocationMapState();
}

class _PickLocationMapState extends State<PickLocationMap> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = {};
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  /// Fetches the user's current location and sets it as the initial map position
  Future<void> _setInitialLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _selectedLocation!,
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),
      );
    });

    // Animate camera to current location
    if (_mapController.isCompleted) {
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedLocation!, 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.7749, -122.4194), // San Francisco as fallback
            zoom: 12,
          ),
          mapType: MapType.normal,
          markers: _markers,
          zoomControlsEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (controller) {
            if (!_mapController.isCompleted) {
              _mapController.complete(controller);
            }
          },
          onTap: (LatLng tappedPoint) {
            setState(() {
              _selectedLocation = tappedPoint;
              _markers.clear();
              _markers.add(
                Marker(
                  markerId: const MarkerId('selected_location'),
                  position: tappedPoint,
                  infoWindow: const InfoWindow(title: 'Selected Location'),
                ),
              );

              // Callback with selected coordinates
              widget.onLocationPicked(
                tappedPoint.latitude,
                tappedPoint.longitude,
              );
            });
          },
        ),
      ),
    );
  }
}
