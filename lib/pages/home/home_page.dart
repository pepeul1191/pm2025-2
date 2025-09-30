import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '/pages/books/books_page.dart';
import '/pages/scanner/scanner_page.dart';
import '/pages/favorites/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());

  int _currentIndex = 0;

  final List<Widget> _screens = [BooksPage(), ScannerPage(), FavoritesPage()];

  Widget _bottonNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Código QR'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
      ],
      // Opcional: personalizar colores
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      showUnselectedLabels: true,
    );
  }

  Widget _alert(BuildContext context) {
    return AlertDialog(
      title: Text('¿Salir de la aplicación?'),
      content: Text('¿Estás seguro de que quieres salir de BiblioApp ULima?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => {
            control.logout()
          },
          child: Text('Salir'),
        ),
      ],
    );
  }

  Widget _about(BuildContext context) {
    return AlertDialog(
      title: Text('Acerca de BiblioApp ULima'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Versión: 1.0.0',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'BiblioApp ULima es una aplicación móvil desarrollada como proyecto académico para el curso de Programación de Aplicaciones Móviles de la Universidad de Lima.',
            ),
            SizedBox(height: 10),
            Text(
              'Esta aplicación permite gestionar el acceso a los recursos bibliográficos de la universidad, facilitando la búsqueda de libros, consulta de disponibilidad y gestión de favoritos.',
            ),
            SizedBox(height: 10),
            Text(
              'Desarrollado con Flutter y Dart.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              '© 2024 - Universidad de Lima',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cerrar'),
        ),
      ],
    );
  }

  PreferredSizeWidget _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        'BiblioApp ULima',
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onSelected: (value) async {
            if (value == 'edit_profile') {
              Navigator.pushNamed(context, '/profile');
            } else if (value == 'about') {
              await showDialog(
                context: context,
                builder: (context) => _about(context),
              );
            } else if (value == 'logout') {
              await showDialog(
                context: context,
                builder: (context) => _alert(context),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'edit_profile',
                child: Text('Editar Perfil'),
              ),
              PopupMenuItem(value: 'about', child: Text('Acerca de')),
              PopupMenuItem(value: 'logout', child: Text('Cerrar Sesión')),
            ];
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mostrar diálogo de confirmación
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => _alert(context),
        );

        return shouldPop ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appbar(context),
        body: _screens[_currentIndex],
        bottomNavigationBar: _bottonNavBar(context),
      ),
    );
  }
}
