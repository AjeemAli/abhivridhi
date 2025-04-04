import 'package:abhivridhiapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/theme/app_theme.dart';
import 'models/face_image_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FaceImageAdapter());

  // Open the box only if it's not already open
  if (!Hive.isBoxOpen('face_images')) {
    await Hive.openBox<FaceImage>('face_images');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filllo Parcel',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/welcome',
      getPages: AppRoutes.routes,

    );
  }
}


