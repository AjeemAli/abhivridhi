import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import '../../core/services/location_service.dart';


class TrackMapWidget extends StatefulWidget {
  const TrackMapWidget({super.key});

  @override
  _TrackMapWidgetState createState() => _TrackMapWidgetState();
}

class _TrackMapWidgetState extends State<TrackMapWidget> {
  final Completer<GoogleMapController> _mapController = Completer();

  final LatLng _fromLocation = LatLng(28.7041, 77.1025); // Delhi
  final LatLng _toLocation = LatLng(28.5355, 77.3910); // Noida

  Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  bool _isFullScreen = false;

  LatLng? _currentLocation;

  final String googleApiKey = "AIzaSyC3AI7lc3YalTrC0reH3sXsoAWvr9f2R8w";

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _setMarkers();
    _drawRoute();
    _getCurrentLocation();
  }

  // Set pickup and drop markers
  void _setMarkers() {
    _markers.addAll([
      Marker(
        markerId: const MarkerId("from"),
        position: _fromLocation,
        infoWindow: const InfoWindow(title: "Pickup Location"),
      ),
      Marker(
        markerId: const MarkerId("to"),
        position: _toLocation,
        infoWindow: const InfoWindow(title: "Delivery Location"),
      ),
    ]);
  }

  // Draw route using PolylinePoints
  Future<void> _drawRoute() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleApiKey,
      request: PolylineRequest(
        origin: PointLatLng(_fromLocation.latitude, _fromLocation.longitude),
        destination: PointLatLng(_toLocation.latitude, _toLocation.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    } else {
      debugPrint("Failed to get route: ${result.errorMessage}");
    }
  }

  // Fetch current location and center the camera
  Future<void> _getCurrentLocation() async {
    Position? position = await LocationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      final controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(_currentLocation!, 14));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: _isFullScreen ? MediaQuery.of(context).size.height : 300,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _fromLocation,
              zoom: 14,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                color: Colors.blue,
                width: 4,
                points: _polylineCoordinates,
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          ),

          // Fullscreen button
          Positioned(
            top: 10,
            right: 10,
            child: FloatingActionButton(
              mini: true,
              heroTag: "fullscreen",
              onPressed: () {
                setState(() {
                  _isFullScreen = !_isFullScreen;
                });
              },
              child: Icon(_isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
            ),
          ),

          // Center on current location button
          Positioned(
            bottom: 16,
            right: 10,
            child: FloatingActionButton(
              mini: true,
              heroTag: "center_location",
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}

