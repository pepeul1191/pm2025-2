import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'book_controller.dart';

class BookPage extends StatelessWidget {
  BookController control = Get.put(BookController());
  final String pdfPath = 'assets/sample.pdf';

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print("Error loading PDF: $error");
          // Muestra un mensaje de error en la UI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 50, color: Colors.red),
                SizedBox(height: 16),
                Text('Error al cargar el PDF'),
                SizedBox(height: 8),
                Text('Error: $error', textAlign: TextAlign.center),
              ],
            ),
          );
        },
        onViewCreated: (PDFViewController pdfViewController) {
          print("PDF view created");
        },
      ),
    );
  }

  List<Widget> _appmenu(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          print('Botón de menú presionado');
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Título del Libro'),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        actions: _appmenu(context),
      ),
      body: _buildBody(context),
    );
  }
}
