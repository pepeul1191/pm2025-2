import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;

class BookController extends GetxController {
  var pdfControllerPinch = Rx<PdfControllerPinch?>(null);
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  Future<void> loadPdf(Book book) async {
    try {
      final pdfUrl = '${BASE_URL}${book.pdf}';
      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        final controller = PdfControllerPinch(
          document: Future.value(
            await PdfDocument.openData(response.bodyBytes),
          ),
        );
        pdfControllerPinch.value = controller;
        isLoading.value = false;
      } else {
        throw Exception('Error al cargar PDF: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
    }
  }
}
