import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';

class TrackMapWidget extends StatefulWidget {
  const TrackMapWidget({super.key});

  @override
  _TrackMapWidgetState createState() => _TrackMapWidgetState();
}

class _TrackMapWidgetState extends State<TrackMapWidget> {
  final Completer<GoogleMapController> _mapController = Completer();

  // From and To Coordinates
  final LatLng _fromLocation = LatLng(28.7041, 77.1025); // Delhi
  final LatLng _toLocation = LatLng(28.5355, 77.3910); // Noida

  Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  final String googleApiKey = "AIzaSyCcr56ZxhkvdYntPYfiUmPruGo8kt4eqWk";

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _setMarkers();
    _drawRoute();
  }

  // Add Markers for From and To Locations
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

  // Draw Route between From and To
  Future<void> _drawRoute() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleApiKey,
      request: PolylineRequest(
        origin: PointLatLng(_fromLocation.latitude, _fromLocation.longitude),
        destination: PointLatLng(_toLocation.latitude, _toLocation.longitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Szabo, Yaba Lagos Nigeria")],
      ),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 300, // Increased height for better display
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _fromLocation,
          zoom: 12,
        ),
        markers: _markers,
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
    );
  }
}
