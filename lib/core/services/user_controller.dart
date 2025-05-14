import 'package:get/get.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? profileImage;

  User({this.id, this.name, this.email, this.phone, this.profileImage});
}

class UserController extends GetxController {
  final Rx<User> user = User().obs;

  @override
  void onInit() {
    super.onInit();
    // Load user data from storage or API
    loadUserData();
  }

  Future<void> loadUserData() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    user.value = User(
      id: '123',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+1 234 567 8900',
      profileImage: 'https://example.com/profile.jpg',
    );
  }

  Future<void> logout() async {
    // Clear user data and auth tokens
    user.value = User();
    // Add your logout logic here
  }
}