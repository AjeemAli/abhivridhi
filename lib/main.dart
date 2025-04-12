import 'package:abhivridhiapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/search_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/controller_binding.dart';
import 'models/face_image_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FaceImageAdapter());


  await Get.putAsync(() => SharedPreferences.getInstance());
  Get.put(SearchOrderController());


  // Open the box only if it's not already open
  if (!Hive.isBoxOpen('face_images')) {
    await Hive.openBox<FaceImage>('face_images');
  }

  // Check if this is first run
  final prefs = await SharedPreferences.getInstance();
  bool isFirstRun = prefs.getBool('is_first_run') ?? true;

  if (isFirstRun) {
    // Request location permission on first run
    await _handleFirstRunLocationPermission();
    await prefs.setBool('is_first_run', false);
  }

  runApp(const MyApp());
}

Future<void> _handleFirstRunLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'Filllo Parcel',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/welcome',
      getPages: AppRoutes.routes,
    );
  }
}


