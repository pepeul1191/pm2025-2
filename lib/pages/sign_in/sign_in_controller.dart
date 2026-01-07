import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/responses/auth_response.dart';
import 'package:biblioapp/services/session_service.dart';
import 'package:biblioapp/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString message = ''.obs;
  RxBool success = false.obs;
  UsersService userService = UsersService();
  SessionService sessionService = SessionService();

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign-up');
  }

  void goToResetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/reset-password');
  }

  void login(BuildContext context) async {
    String user = username.text;
    String passwordStr = password.text;
    GenericResponse<dynamic> response = await userService.signIn(
      user,
      passwordStr,
    );
    // actualizar vista
    message.value = response.message;
    success.value = response.success;
    if (response.success) {
      AuthResponse data = response.data;
      sessionService.setLoggedIn(true);
      print('1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      print(data.user);
      print('2 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');

      sessionService.saveUser(data.user);
      sessionService.saveToken(data.tokens);
      Navigator.pushNamed(context, '/home');
    }
  }
}
