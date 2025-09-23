import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserService userService = UserService();
  RxString message = ''.obs;
  RxBool success = false.obs;

  SignInController() {}

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign-up');
  }

  void goToResetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/reset-password');
  }

  void login(BuildContext context) {
    String user = userController.text;
    String password = passwordController.text;

    GenericResponse<dynamic> response = userService.signIn(user, password);
    message.value = response.message;
    success.value = response.success;
    if (response.success) {
      Navigator.pushNamed(context, '/home');
    }
  }
}
