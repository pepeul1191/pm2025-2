import 'dart:convert';
import 'dart:io';

import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/responses/auth_response.dart';
import 'package:biblioapp/responses/file_upload_response.dart';
import 'package:biblioapp/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UsersService extends ApplicationService {
  Future<GenericResponse> signIn(String username, String password) async {
    try {
      if (username == '' || password == '') {
        return GenericResponse(
          success: false,
          data: null,
          message: "Debe de ingresar usuario y contraseña",
          error: "ERROR!",
        );
      }

      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/v2/sign-in'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'username': username, 'password': password}),
      );

      print('1 ++++++++++++++++++++++++++++++');
      print(httpResponse.body);
      print('2 ++++++++++++++++++++++++++++++');

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<AuthResponse>.fromJson(
        jsonMap,
        fromJsonT:
            (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      return GenericResponse(
        success: false,
        data: null,
        message: "Ocurrio un error al validar el usuario",
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse> uploadProfileImage(File imageFile) async {
    try {
      // Crear la solicitud multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${BASE_URL}api/v1/files'),
      );

      // Agregar headers de autorización
      request.headers['Authorization'] =
          'Bearer ${session.getToken()?.biblioapp}';

      // Agregar el archivo
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Este nombre debe coincidir con el que espera el backend (params[:file])
          imageFile.path,
        ),
      );

      // Enviar la solicitud
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Respuesta de subida de imagen: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);

        return GenericResponse<FileUploadResponse>.fromJson(
          jsonMap,
          fromJsonT:
              (data) =>
                  FileUploadResponse.fromJson(data as Map<String, dynamic>),
        );
      } else {
        return GenericResponse(
          success: false,
          data: null,
          message: "Error al subir la imagen",
          error: "Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print('Error en uploadProfileImage: $e');
      return GenericResponse(
        success: false,
        data: null,
        message: "Ocurrió un error al subir la imagen",
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse> signIn3(String user, String password) async {
    if (user == '' || password == '') {
      return GenericResponse(
        success: false,
        data: null,
        message: "Debe de ingresar usuario y contraseña",
        error: "ERROR!",
      );
    }
    if (user == 'admin' && password == '123') {
      String jsonString = await rootBundle.loadString('assets/jsons/user.json');
      //print(jsonString);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      final response = GenericResponse<AuthResponse>.fromJson(
        jsonMap,
        fromJsonT:
            (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );
      return response;
    } else {
      return GenericResponse(
        success: false,
        data: null,
        message: "Usuario y contraseña no válidos",
        error: "ERROR!",
      );
    }
  }

  GenericResponse<dynamic> signIn2(String user, String password) {
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
}
