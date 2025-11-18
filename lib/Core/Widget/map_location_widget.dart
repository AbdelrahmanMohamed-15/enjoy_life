import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapLocationWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapLocationWidget> createState() => _MapLocationWidgetState();
}

class _MapLocationWidgetState extends State<MapLocationWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            // Explicitly move camera to ensure correct position
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(widget.latitude, widget.longitude),
                  14.0,
                ),
              );
            });
          },
          markers: {
            Marker(
              markerId: MarkerId('event_location'),
              position: LatLng(widget.latitude, widget.longitude),
            ),
          },
        ),
      ),
    );
  }
}
