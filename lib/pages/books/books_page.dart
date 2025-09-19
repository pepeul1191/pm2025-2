import 'package:biblioapp/components/item_book/item_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'books_controller.dart';

class BooksPage extends StatelessWidget {
  BooksController control = Get.put(BooksController());

  List<Widget> _books(BuildContext context) {
    return [
      ItemBook(),
      ItemBook(),
      ItemBook(),
      ItemBook(),
      ItemBook(),
      ItemBook(),
    ];
  }

  Widget _topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Libros Encontrados: 123"),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
              padding: EdgeInsets.zero, // Elimina espaciado
              constraints: BoxConstraints(), // Elimina tamaño mínimo
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ), // Corregido: usar symmetric en lugar de only
            child: _topBar(context),
          ),
          Expanded(
            // Corregido: agregar Expanded para que el ListView ocupe el espacio restante
            child: ListView(
              // Corregido: usar ListView en lugar de ScrollView
              padding: EdgeInsets.zero, // Eliminar padding
              children: _books(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}
