import 'package:biblioapp/components/book_item_list.dart';
import 'package:biblioapp/components/geren_tag.dart';
import 'package:biblioapp/models/book.dart';
import 'package:biblioapp/models/genre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'books_list_controller.dart';

class BooksListPage extends StatelessWidget {
  BooksListController control = Get.put(BooksListController());
  DateTime? _startDate;
  DateTime? _endDate;

  BooksListPage({super.key}) {
    control.listBooks();
    control.listGerens();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate
              ? _startDate ?? DateTime.now()
              : _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      /*setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });*/
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text('Criterios de Búsqueda', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Fechas', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  // Campo Fecha Inicio
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Inicio',
                        prefixIcon: Icon(Icons.calendar_today, size: 20),
                        border: UnderlineInputBorder(), // Solo border bottom
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      readOnly: true, // Para simular input type="date"
                      onTap: () {
                        // Aquí puedes abrir el date picker
                        _selectDate(context, true);
                      },
                    ),
                  ),

                  SizedBox(width: 16), // Espacio entre los campos
                  // Campo Fecha Fin
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Fin',
                        prefixIcon: Icon(Icons.calendar_today, size: 20),
                        border: UnderlineInputBorder(), // Solo border bottom
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      readOnly: true, // Para simular input type="date"
                      onTap: () {
                        // Aquí puedes abrir el date picker
                        _selectDate(context, false);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Tópicos', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),
              Obx(() {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(control.gerens.length, (index) {
                    final genre = control.gerens[index];

                    return GerenTag(
                      genre: genre,
                      initialSelected: control.isGenreSelected(genre),
                      onTap: (isSelected) {
                        //print('futura llamada al controlador de la vista');
                        //print(genre);
                        //print(isSelected);
                        control.gerenSelected(genre, isSelected);
                      },
                    );
                  }),
                );
              }),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1, // Ocupa 1 parte del espacio disponible
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          control.filterByGeners();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Buscar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Espacio entre botones (opcional)
                  Expanded(
                    flex:
                        1, // Ocupa 1 parte del espacio disponible (misma proporción)
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          control.clearSelectedGerensAndReload();
                          Navigator.pop(context);
                          control.listBooks();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Limpiar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
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
                Obx(() => Text("Libros encontrados: ${control.books.length}")),
                GestureDetector(
                  onTap: () {
                    // Aquí puedes colocar el evento que quieres ejecutar cuando el texto sea tocado
                    print("filtro tocado");
                    _showBottomSheet(context);
                  },
                  child: Icon(Icons.filter_alt_outlined),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (control.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                // listar libros
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
