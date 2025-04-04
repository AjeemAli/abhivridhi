import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/utils/app_color.dart';
import '../../models/face_image_model.dart';
import '../../widgets/custom_button.dart';

class FaceIdScreen extends StatefulWidget {
  const FaceIdScreen({super.key});

  @override
  State<FaceIdScreen> createState() => _FaceIdScreenState();
}

class _FaceIdScreenState extends State<FaceIdScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  CameraController? _cameraController;
  String? _imagePath;
  double _scanProgress = 0.0;
  late Box<FaceImage> _faceImageBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
    _initializeCamera();
  }

  // Initialize Hive Box
  Future<void> _initializeHive() async {
    _faceImageBox = await Hive.openBox<FaceImage>('face_images');
    _loadStoredFaceImage();
  }

  // Initialize Camera
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(frontCamera, ResolutionPreset.high);
    await _cameraController!.initialize();
    setState(() {});
  }

  // Simulate Face Scan Progress
  Future<void> _simulateFaceScan() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300)); // Simulated delay
      setState(() {
        _scanProgress = i * 10.0;
      });
    }
  }

  // Authenticate using Face ID
  Future<void> _authenticate() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isDeviceSupported = await _localAuth.isDeviceSupported();
      List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();

      if (!canCheckBiometrics || availableBiometrics.isEmpty || !isDeviceSupported) {
        _showMessage("Biometric authentication is not available on this device.");
        return;
      }

      bool authenticated = await _localAuth.authenticate(
        localizedReason: "Scan your face to authenticate",
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: false,
        ),
      );

      if (authenticated) {
        _captureImage();
      } else {
        _showMessage("Authentication Failed");
      }
    } catch (e) {
      _showMessage("Error: $e");
    }
  }

  // Capture and store face image
  Future<void> _captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _showMessage("Camera not initialized");
      return;
    }

    try {
      final image = await _cameraController!.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = "${directory.path}/face_image.jpg";
      await image.saveTo(imagePath);

      // Save to Hive Database
      _faceImageBox.put('saved_face', FaceImage(imagePath));

      setState(() {
        _imagePath = imagePath;
      });

      _showMessage("Face Image Captured & Stored");
    } catch (e) {
      _showMessage("Error capturing image: $e");
    }
  }

  // Load stored face image
  void _loadStoredFaceImage() {
    var savedFace = _faceImageBox.get('saved_face');

    if (savedFace != null) {
      setState(() {
        _imagePath = savedFace.imagePath;
      });
    }
  }

  // Show messages using Snackbar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceImageBox.close(); // Close Hive box when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face ID Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _cameraController != null && _cameraController!.value.isInitialized
                ? Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CameraPreview(_cameraController!),
                  ),
                ),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: CircularProgressIndicator(
                    value: _scanProgress / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            )
                : const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 20),

            Column(
              children: [
                const Text("Face Scan"),
                Text("${_scanProgress.toInt()}%"),
              ],
            ),

            const SizedBox(height: 50),

            CustomButton(
              onPressed: _authenticate,
              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text: 'Scan My Face',
              textColor: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              isDisabled: false,
              hasShadow: false,
              isOutlined: false,
              color: AppColors.btnColor,
            ),

            if (_imagePath != null)
              Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Scanned Face Image:"),
                  Image.file(File(_imagePath!), width: 200, height: 200),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
