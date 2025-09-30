import 'dart:convert';

import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/models/book.dart';
import 'package:flutter/services.dart';

class BooksService {
  List<Book> _bookListFromJson(dynamic json) {
    return (json as List)
        .map((bookJson) => Book.fromJson(bookJson as Map<String, dynamic>))
        .toList();
  }

  Future<GenericResponse> fetchAll() async {
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
}
