import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'book_controller.dart';
import 'package:pdfx/pdfx.dart';

class BookPage extends StatelessWidget {
  BookPage({super.key});

  // Usamos Get.put() para que GetX maneje el estado
  final BookController controller = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    // Recibimos el libro pasado por las rutas
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;

    // Cargar el PDF
    controller.loadPdf(book);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar simple dentro de la vista
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      book.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Usamos Obx para observar los cambios del estado del controller
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.hasError.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${controller.errorMessage.value}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            controller.loadPdf(book); // Reintentar
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }

                return PdfViewPinch(
                  controller: controller.pdfControllerPinch.value!,
                  builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                    options: const DefaultBuilderOptions(),
                    documentLoaderBuilder:
                        (_) => const Center(child: CircularProgressIndicator()),
                    pageLoaderBuilder:
                        (_) => const Center(child: CircularProgressIndicator()),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
