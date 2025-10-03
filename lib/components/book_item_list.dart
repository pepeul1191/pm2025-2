import 'package:biblioapp/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookItemList extends StatelessWidget {
  final Book book;
  BookItemList({super.key, required this.book});

  Widget _menu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      onSelected: (value) async {
        if (value == 'view_detail') {
          Navigator.pushNamed(context, '/book', arguments: book);
        } else if (value == 'read') {
          print('read');
        } else if (value == 'comentaries') {
          print('comentaries');
        } else if (value == 'rate') {
          print('rate');
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'view_detail',
            child: Text('Ver Detalle'),
          ),
          PopupMenuItem(
            value: 'read', 
            child: Text('Leer')),
          PopupMenuItem(
            value: 'comentaries', 
            child: Text('Comentarios')),
          PopupMenuItem(
            value: 'rate', 
            child: Text('Calificar')),
        ];
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1.0,
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
                return Image.asset(
                  'assets/images/libro.png',
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
            ),
            SizedBox(width: 20),
            Expanded( // ← CRITICAL FIX: Add Expanded here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Allow title to wrap to 2 lines
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Autores FALTA!!!!!!!!!",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2),
                  Text("Paginas ${book.pages}"),
                  SizedBox(height: 2),
                  Text("ISBN: ${book.isbn}"),
                  SizedBox(height: 2),
                  Text(
                    "Editorial: ${book.publisher.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2),
                  Text("Año de Publicación: ${book.publicationYear}"),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 18, // Slightly smaller icons
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10), // Reduced spacing
            _menu(context),
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