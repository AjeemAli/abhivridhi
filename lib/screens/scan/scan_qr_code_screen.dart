import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../core/services/shipping_details_controller.dart';
import '../track_order/track_order_screen.dart';


// class QRScanScreen extends StatefulWidget {
//   const QRScanScreen({super.key});
//
//   @override
//   State<QRScanScreen> createState() => _QRScanScreenState();
// }
//
// class _QRScanScreenState extends State<QRScanScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   final ShippingDetailsMoreController detailsController = Get.find();
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan Shipping QR Code'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.orange,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: MediaQuery.of(context).size.width * 0.8,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text(
//                 'Align the QR code within the frame to scan',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       try {
//         final data = jsonDecode(scanData.code!);
//         if (data['order_id'] != null) {
//           // Stop camera
//           controller.dispose();
//           // Navigate to tracking screen
//           Get.to(
//                 () => TrackOrderScreen(orderId: data['order_id']),
//           );
//         }
//       } catch (e) {
//         Get.snackbar(
//           'Invalid QR Code',
//           'Please scan a valid shipping QR code',
//           duration: const Duration(seconds: 2),
//         );
//       }
//     });
//   }
// }