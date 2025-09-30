import 'package:biblioapp/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookItemList extends StatelessWidget {
  final Book book;
  BookItemList({super.key, required this.book});

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title, // titulo
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Autores FALTA!!!!!!!!!"),
                Text("Paginas ${book.pages}"),
                Text("ISBN: ${book.isbn}"),
                Text("Editorial: ${book.publisher.name}"),
                Text("Año de Publicación: ${book.publicationYear}"),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 20),
            Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
