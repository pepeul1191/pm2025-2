import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void logout(){
    print("después borraremos la sesión del localstorage...");
    SystemNavigator.pop(); // Cerrar la aplicación
  }
}
