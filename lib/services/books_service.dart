import 'dart:convert';

import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/models/book.dart';
import 'package:biblioapp/models/genre.dart';
import 'package:biblioapp/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BooksService extends ApplicationService{

  List<Book> _bookListFromJson(dynamic json) {
    return (json as List)
        .map((bookJson) => Book.fromJson(bookJson as Map<String, dynamic>))
        .toList();
  }

  Future<GenericResponse> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/v3/books'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.biblioapp}'
        },
      );

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<Book>> response =
          GenericResponse<List<Book>>.fromJson(
            jsonMap,
            fromJsonT: _bookListFromJson,
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse(
        success: false,
        data: null,
        message: "Error no esperado en listar los libros",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse> fetchAll2() async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/jsons/books.json',
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      GenericResponse<List<Book>> response =
          GenericResponse<List<Book>>.fromJson(
            jsonMap,
            fromJsonT: _bookListFromJson,
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse(
        success: false,
        data: null,
        message: "Error no esperado en listar los libros",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<List<Book>>> filter(List<Genre> selectedGerens) async {
    try {
      // Generar el string de IDs separados por coma
      String genresIdsParam = selectedGerens
          .map((genre) => genre.id.toString())
          .join(',');

      final httpResponse = await http.get(
        Uri.parse(
          '${BASE_URL}api/v3/books',
        ).replace(queryParameters: {'genres_ids': genresIdsParam}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.biblioapp}'
        },
      );

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<Book>> response =
          GenericResponse<List<Book>>.fromJson(
            jsonMap,
            fromJsonT: _bookListFromJson,
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<Book>>(
        success: false,
        data: null,
        message: "Error no esperado en filtrar los libros",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<List<Book>>> filter2(
    List<Genre> selectedGerens,
  ) async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/jsons/books.json',
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      GenericResponse<List<Book>> response =
          GenericResponse<List<Book>>.fromJson(
            jsonMap,
            fromJsonT: _bookListFromJson,
          );

      // Si no hay géneros seleccionados, devolver todos los libros
      if (selectedGerens.isEmpty) {
        return response;
      }

      // Filtrar libros que contengan AL MENOS UNO de los géneros seleccionados
      if (response.success && response.hasData) {
        List<Book> filteredBooks =
            response.data!.where((book) {
              // Verificar si el libro tiene al menos un género que coincida con los seleccionados
              return book.genres.any(
                (bookGenre) => selectedGerens.any(
                  (selectedGenre) => selectedGenre.id == bookGenre.id,
                ),
              );
            }).toList();

        // Devolver respuesta con libros filtrados
        return GenericResponse<List<Book>>(
          success: true,
          data: filteredBooks,
          message: response.message,
          error: response.error,
        );
      }

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<Book>>(
        success: false,
        data: null,
        message: "Error no esperado en filtrar los libros",
        error: stackTrace.toString(),
      );
    }
  }
}
