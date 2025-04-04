import 'package:abhivridhiapp/screens/dashboard/dashboard_screen.dart';
import 'package:abhivridhiapp/screens/profile/user_profile_screen.dart';
import 'package:abhivridhiapp/screens/support/support_screen.dart';
import 'package:abhivridhiapp/screens/track_order/track_order_screen.dart';
import 'package:get/get.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/auth/login_options_screen.dart';
import 'screens/auth/phone_signup_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/auth/username_setup_screen.dart';
import 'screens/auth/password_setup_screen.dart';
import 'screens/auth/face_id_screen.dart';
import 'screens/auth/login_with_phone.dart';
import 'screens/auth/login_with_password.dart';
import 'screens/home/home_screen.dart';
import 'screens/nearby_couriers/nearby_couriers_screen.dart';
import 'screens/search/search_order_screen.dart';
import 'screens/search/search_result_screen.dart';
import 'screens/scan/scan_qr_code_screen.dart';
import 'screens/shipment/add_shipment_screen.dart';
import 'screens/shipment/parcel_screen.dart';
import 'screens/shipment/sender_screen.dart';
import 'screens/shipment/letter_parcel_screen.dart';
import 'screens/payment/cart_screen.dart';
import 'screens/payment/add_card_payment_screen.dart';
import 'screens/payment/payment_success_screen.dart';
import 'screens/tracking/live_tracking_screen.dart';
import 'screens/tracking/tracking_history_screen.dart';
import 'screens/tracking/tracking_history_view_screen.dart';

class AppRoutes {
  static final routes = [

    GetPage(name: '/welcome', page: () => WelcomeScreen()),
    GetPage(name: '/onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/login-options', page: () => LoginOptionsScreen()),
    GetPage(name: '/phone-signup', page: () => PhoneSignupScreen()),
    GetPage(name: '/otp', page: () => OtpScreen()),
    GetPage(name: '/username-setup', page: () => UsernameSetupScreen()),
    GetPage(name: '/password-setup', page: () => PasswordSetupScreen()),
    GetPage(name: '/face-id', page: () => FaceIdScreen()),
    GetPage(name: '/login-with-phone', page: () => LoginWithPhone()),
    GetPage(name: '/login-with-password', page: () => LoginWithPassword()),


    /// Home Screen

    GetPage(name: '/dashboard', page: () => DashboardScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/track-order', page: () => TrackOrderScreen()),
    GetPage(name: '/user-profile', page: () => UserProfileScreen()),
    GetPage(name: '/nearby-couriers', page: () => NearbyCouriersScreen()),
    GetPage(name: '/support', page: () => SupportScreen()),
    GetPage(name: '/search-order', page: () => SearchOrderScreen()),
    GetPage(name: '/search-result', page: () => SearchResultScreen()),
    GetPage(name: '/scan-qr', page: () => ScanQrCodeScreen()),
    GetPage(name: '/add-shipment', page: () => AddShipmentScreen()),
    GetPage(name: '/parcel', page: () => ParcelScreen()),
    GetPage(name: '/sender', page: () => SenderScreen()),
    GetPage(name: '/letter-parcel', page: () => LetterParcelScreen()),
    GetPage(name: '/cart', page: () => CartScreen()),
    GetPage(name: '/add-card-payment', page: () => AddCardBottomSheet(onCardTypeSelected: (String ) {  },)),
    GetPage(name: '/payment-success', page: () => PaymentSuccessScreen()),
    GetPage(name: '/live-tracking', page: () => LiveTrackingScreen()),
    GetPage(name: '/tracking-history', page: () => TrackingHistoryScreen()),
    GetPage(name: '/tracking-history-view', page: () => TrackingHistoryViewScreen()),
  ];
}
