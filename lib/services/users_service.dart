import 'dart:convert';

import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/responses/login_response.dart';
import 'package:flutter/services.dart';

class UsersService {
  GenericResponse<dynamic> signIn(String user, String password) {
    if (user == '' || password == '') {
      return GenericResponse(
        success: false,
        data: null,
        message: "Debe de ingresar usuario y contraseña",
        error: "ERROR!",
      );
    }
    if (user == 'admin' && password == '123') {
      return GenericResponse(
        success: true,
        data: null,
        message: "Vamos bien",
        error: null,
      );
    } else {
      return GenericResponse(
        success: false,
        data: null,
        message: "Usuario y contraseña no válidos",
        error: "ERROR!",
      );
    }
  }

  LoginResponse _loginResponseFromJson(dynamic json) {
    return LoginResponse.fromJson(json as Map<String, dynamic>);
  }

  Future<GenericResponse<LoginResponse>> login(
    String username,
    String password,
  ) async {
    try {
      // Simular llamada a API - en producción sería HTTP
      String jsonString = await rootBundle.loadString(
        'assets/jsons/user.json', // Tu JSON de login
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      
      GenericResponse<LoginResponse> response =
          GenericResponse<LoginResponse>.fromJson(
        jsonMap,
        fromJsonT: _loginResponseFromJson,
      );

      return response;
    } catch (e, stackTrace) {
      print('Error en login: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<LoginResponse>(
        success: false,
        data: null,
        message: "Error en el proceso de login",
        error: stackTrace.toString(),
      );
    }
  }
}
