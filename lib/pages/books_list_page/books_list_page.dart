import 'package:biblioapp/components/book_item_list.dart';
import 'package:biblioapp/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'books_list_controller.dart';

class BooksListPage extends StatelessWidget {
  BooksListController control = Get.put(BooksListController());

  BooksListPage({super.key}) {
    control.listBooks();
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween, // ← Esto empuja los elementos a los extremos
              children: [
                Text("Libros encontrados: 123"),
                Icon(Icons.filter_alt_outlined),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (control.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: control.books.length,
                  itemBuilder: (context, index) {
                    Book book = control.books[index];
                    return BookItemList(book: book);
                    //return Text(book.title);
                  },
                );
              }),
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
