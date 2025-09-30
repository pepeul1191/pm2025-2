import 'package:biblioapp/pages/books_list_page/books_list_page.dart';
import 'package:biblioapp/pages/comentaries/comentaries_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'books_controller.dart';

class BooksPage extends StatelessWidget {
  BooksController control = Get.put(BooksController());

  BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null, // Sin AppBar
        body: Column(
          children: [
            // TabBar personalizado
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                tabs: [Tab(text: 'Libros'), Tab(text: 'Colecciones')],
                indicator: BoxDecoration(
                  color:
                      Theme.of(
                        context,
                      ).colorScheme.surface, // Fondo de todo el tab
                ),
                indicatorSize:
                    TabBarIndicatorSize.tab, // Que cubra toda la pestaña
                indicatorWeight: 0, // Eliminar la línea inferior
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Colors.white70,
              ),
            ),
            // Contenido de las pestañas
            Expanded(
              child: TabBarView(
                children: [
                  SafeArea(child: BooksListPage()),
                  SafeArea(child: ComentariesPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
