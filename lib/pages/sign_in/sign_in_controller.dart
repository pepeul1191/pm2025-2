import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString message = ''.obs;
  RxBool success = false.obs;
  UsersService userService = UsersService();

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign-up');
  }

  void goToResetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/reset-password');
  }

  void login(BuildContext context) {
    String user = username.text;
    String passwordStr = password.text;
    GenericResponse<dynamic> response = userService.signIn(user, passwordStr);
    // actualizar vista
    message.value = response.message;
    success.value = response.success;
    if (response.success) {
      Navigator.pushNamed(context, '/home');
    }
  }
}
