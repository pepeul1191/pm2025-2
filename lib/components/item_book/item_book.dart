import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'item_book_controller.dart';

class ItemBook extends StatelessWidget {
  ItemBookController control = Get.put(ItemBookController());

  Widget _menu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      onSelected: (String value) {
        switch (value) {
          case 'detail':
            print('Configuración seleccionada');
            break;
          case 'read':
            Navigator.pushNamed(context, '/book');
            break;
          case 'comentaries':
            print('Configuración seleccionada');
            break;
          case 'rate':
            print('Configuración seleccionada');
            break;
          default:
            print('Opción desconocida');
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(value: 'detail', child: Text('Ver Detalle')),
        PopupMenuItem(value: 'read', child: Text('Leer')),
        PopupMenuItem(value: 'comentaries', child: Text('Comentarios')),
        PopupMenuItem(value: 'rate', child: Text('Calificar')),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          // 30% - Imagen
          Flexible(
            flex: 3, // 30%
            child: Image.network(
              'https://40729136-0daa-4be7-bbf2-5c64410ef3aa-00-2d22h14xb93qv.worf.replit.dev/images/ulises-web.png',
              width: 80,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder:
                  (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) {
                    return Image.asset(
                      'assets/images/book.png',
                      width: 80,
                      height: 130,
                      fit: BoxFit.cover,
                    );
                  },
            ),
          ),

          // 10% - Espaciado
          Flexible(
            flex: 1,
            child: SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          ), // 10%
          // 40% - Información
          Flexible(
            flex: 7, // 40%
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MouseTracker.updateWithEvent (package:flutter/src/rendering/mouse_tracker',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Páginas 234'),
                Text('Editorial: Almuzara Libros'),
                Text('Año de publicación: 2000'),
                SizedBox(height: 20),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),

          // 10% - Espaciado
          Flexible(
            flex: 1,
            child: SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          ), // 10%
          // 10% - Icono
          Flexible(
            flex: 1, // 10%
            child: _menu(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.inversePrimary, // Color del borde superior
            width: 1.0, // Grosor del borde
          ),
        ),
      ),
      child: _buildBody(context),
    );
  }
}
