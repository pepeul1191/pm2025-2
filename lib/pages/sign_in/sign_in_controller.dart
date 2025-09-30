import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/responses/login_response.dart';
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

  Future<void> login(BuildContext context) async {
    // Mostrar loading
    String user = username.text;
    String passwordStr = password.text;
    
    // Esperar la respuesta con await
    GenericResponse<LoginResponse>  response = await userService.login(user, passwordStr);
    
    // Actualizar vista con la respuesta
    message.value = response.message;
    success.value = response.success;
    
    if (response.success) {
      // Si necesitas acceder a los datos específicos del login
      if (response.data != null && response.data != null) {
        // Aquí puedes guardar el usuario en sesión
        print('Login exitoso: ${response.data}');
        print(response.data);
        final loginData = response.data as LoginResponse;
        sessionService.saveUser(loginData.user);
        sessionService.saveTokens(loginData.tokens);
      }
      
      // Navegar al home
     Navigator.pushNamed(context, '/home');
    } else {
      // Mostrar error si el login falla
      message.value = response.message;
    }
  }

  void checkUserLooged(BuildContext context){
    if(sessionService.isLoggedIn){
      Navigator.pushNamed(context, '/home');
    }
  }
}
