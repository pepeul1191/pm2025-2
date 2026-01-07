import 'package:biblioapp/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookItemList extends StatelessWidget {
  final Book book;
  BookItemList({super.key, required this.book});

  String _authors(Book book) {
    String rpta = '';
    book.authors.forEach((author) {
      rpta = rpta + author.fullName + ', ';
    });
    return rpta.substring(0, rpta.length - 2);
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:
                Theme.of(
                  context,
                ).colorScheme.outlineVariant, // Color de la línea superior
            width: 1.0, // Grosor de la línea
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              'https://40729136-0daa-4be7-bbf2-5c64410ef3aa-00-2d22h14xb93qv.worf.replit.dev/${book.coverImage}',
              width: 120,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                // Este widget se muestra cuando ocurre un error al cargar la imagen de red.
                return Image.asset(
                  'assets/images/libro.png',
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title, // titulo
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  book.authors.length == 1
                      ? Text("Autor ${book.authors[0].fullName}")
                      : Text("Autores ${_authors(book)}"),
                  Text("Paginas ${book.pages}"),
                  Text("ISBN: ${book.isbn}"),
                  Text("Editorial: ${book.publisher.name}"),
                  Text("Año de Publicación: ${book.publicationYear}"),
                  SizedBox(height: 10),
                  book.averageRating != null
                      ? Row(
                        children: [
                          // Estrellas llenas
                          ...List.generate(book.averageRating!.round(), (
                            index,
                          ) {
                            return Icon(
                              Icons.star,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            );
                          }),
                          // Estrellas vacías
                          ...List.generate(5 - book.averageRating!.round(), (
                            index,
                          ) {
                            return Icon(
                              Icons.star_border, // ← Cambiado a estrella vacía
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant.withOpacity(0.3),
                            );
                          }),
                        ],
                      )
                      : Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star_border_outlined,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          );
                        }),
                      ),
                ],
              ),
            ),
            SizedBox(width: 20),
            _menu(context),
          ],
        ),
      ),
    );
  }

  Widget _menu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onSelected: (value) async {
        //print(book);
        if (value == 'detail') {
          print('detail');
        } else if (value == 'read') {
          Navigator.pushNamed(context, '/book', arguments: book);
        } else if (value == 'comment') {
          print('comment');
        } else if (value == 'rate') {
          print('rate');
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(value: 'detail', child: Text('Ver Detalle')),
          PopupMenuItem(value: 'read', child: Text('Leer')),
          PopupMenuItem(value: 'comment', child: Text('Comentarios')),
          PopupMenuItem(value: 'rate', child: Text('Calificar')),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
