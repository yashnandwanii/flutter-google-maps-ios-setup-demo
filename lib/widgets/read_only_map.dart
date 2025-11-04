import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A widget that displays a read-only Google Map with a marker at a specific location.
/// 
/// Useful for displaying a saved location without allowing user interaction.
class ReadOnlyMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  const ReadOnlyMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> mapController = Completer();

    final LatLng selectedPoint = LatLng(latitude, longitude);

    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('saved_location'),
        position: selectedPoint,
        infoWindow: const InfoWindow(title: 'Saved Location'),
      ),
    };

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: selectedPoint,
            zoom: 16,
          ),
          markers: markers,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          rotateGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: (controller) {
            if (!mapController.isCompleted) {
              mapController.complete(controller);
            }
          },
        ),
      ),
    );
  }
}
