import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/near_courier_controller.dart';

class NearbyPlacesScreen extends StatelessWidget {
  final NearbyPlacesController nearbyPlacesController = Get.put(
    NearbyPlacesController(),
  );

  NearbyPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("Nearby Couriers")),
      body: Obx(() {
        // Checking if the location is still loading
        if (nearbyPlacesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    nearbyPlacesController.currentLatitude.value,
                    nearbyPlacesController.currentLongitude.value,
                  ),
                  zoom: 14,
                ),
                markers: _buildMarkers(),
                onMapCreated: (GoogleMapController controller) {
                  nearbyPlacesController.mapController.complete(controller);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                var courierList =
                    nearbyPlacesController.nearbyPlaces.value.data ?? [];

                if (courierList.isEmpty) {
                  return Center(
                    child: Text(
                      'No nearby stores found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount:
                      nearbyPlacesController.nearbyPlaces.value.data!.length,
                  itemBuilder: (context, index) {
                    var courier =
                        nearbyPlacesController.nearbyPlaces.value.data![index];
                    print("courier $courier");
                    return ListTile(
                      title: Text(courier.storeName ?? 'No Name'),
                      subtitle: Text(courier.storeAddress ?? 'No Address'),
                      trailing: Text(
                        '${courier.distance?.toStringAsFixed(2)} km',
                      ),
                      onTap: () {
                        // Handle courier tap if needed
                      },
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // Add user's current location marker
    markers.add(
      Marker(
        markerId: MarkerId("user_location"),
        position: LatLng(
          nearbyPlacesController.currentLatitude.value,
          nearbyPlacesController.currentLongitude.value,
        ),
        infoWindow: InfoWindow(title: 'You are here'),
      ),
    );

    // Add nearby couriers markers
    if (nearbyPlacesController.nearbyPlaces.value.data != null) {
      for (var place in nearbyPlacesController.nearbyPlaces.value.data!) {
        markers.add(
          Marker(
            markerId: MarkerId(place.id.toString()),
            position: LatLng(
              double.parse(place.latitude!),
              double.parse(place.longitude!),
            ),
            infoWindow: InfoWindow(
              title: place.storeName,
              snippet: place.storeAddress,
            ),
          ),
        );
      }
    }

    return markers;
  }
}
