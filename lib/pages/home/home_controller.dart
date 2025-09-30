import 'package:biblioapp/services/session_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  SessionService sessionService = SessionService();

  void logout(){
    sessionService.clearAll();
    SystemNavigator.pop(); // Cerrar la aplicación
  }
}
