import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapScreen extends StatelessWidget {
  final LatLng fromLocation;
  final LatLng toLocation;
  final Set<Marker> markers;
  final List<LatLng> polylineCoordinates;

  const FullMapScreen({
    super.key,
    required this.fromLocation,
    required this.toLocation,
    required this.markers,
    required this.polylineCoordinates,
  });

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> mapController = Completer();

    return Scaffold(
      appBar: AppBar(title: const Text("Map Full View")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: fromLocation,
          zoom: 14,
        ),
        markers: markers,
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            color: Colors.blue,
            width: 4,
            points: polylineCoordinates,
          ),
        },
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ),
    );
  }
}
