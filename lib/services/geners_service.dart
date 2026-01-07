import 'dart:convert';

import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/models/genre.dart'; // Asegúrate de importar Genre
import 'package:biblioapp/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GerensService extends ApplicationService{

  List<Genre> _genreListFromJson(dynamic json) {
    return (json as List)
        .map((genreJson) => Genre.fromJson(genreJson as Map<String, dynamic>))
        .toList();
  }

  Future<GenericResponse<List<Genre>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/v2/genres'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.biblioapp}'
        },
      );

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<Genre>> response =
          GenericResponse<List<Genre>>.fromJson(
            jsonMap,
            fromJsonT: (data) {
              // El JSON tiene la estructura: {"data": {"gerens": [...]}}
              if (data is List) {
                print('✅ Data es una lista, procesando...');
                return _genreListFromJson(data);
              }
              return <Genre>[];
            },
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<Genre>>(
        success: false,
        data: null,
        message: "Error no esperado en listar los géneros",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<List<Genre>>> fetchAll2() async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/jsons/genres.json',
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      GenericResponse<List<Genre>> response =
          GenericResponse<List<Genre>>.fromJson(
            jsonMap,
            fromJsonT: (data) {
              // El JSON tiene la estructura: {"data": {"gerens": [...]}}
              if (data is Map<String, dynamic> && data['gerens'] != null) {
                return _genreListFromJson(data['gerens']);
              }
              return <Genre>[];
            },
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<Genre>>(
        success: false,
        data: null,
        message: "Error no esperado en listar los géneros",
        error: stackTrace.toString(),
      );
    }
  }
}
