import '/pages/search/search_page.dart';
import '/pages/scanner/scanner_page.dart';
import '/pages/favorites/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());

  int _selectedIndex = 0;

  final List<Widget> _pages = [SearchPage(), ScannerPage(), FavoritesPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Home Page'));
  }

  List<Widget> _appmenu(BuildContext context) {
    return [
      PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String value) {
          // Aquí puedes agregar la lógica para cada opción
          //control.handleMenuOption(value);
          switch (value) {
            case 'setup':
              print('Es una manzana');
              break;
            case 'profile':
              Navigator.pushNamed(context, '/profile');
              break;
            case 'sign-out':
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/sign-in',
                (route) => false,
              );
              break;
            default:
              print('Fruta desconocida');
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(value: 'setup', child: Text('Configuración')),
          PopupMenuItem(value: 'profile', child: Text('Perfil')),
          PopupMenuItem(value: 'sign-out', child: Text('Cerrar sesión')),
        ],
      ),
    ];
  }

  Widget _buildIcon(IconData outlineIcon, IconData filledIcon, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          _selectedIndex == index ? filledIcon : outlineIcon,
          size: _selectedIndex == index ? 28 : 24,
        ),
        if (_selectedIndex == index)
          Container(
            margin: EdgeInsets.only(top: 4),
            height: 3,
            width: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  Widget _bottomNavbar(BuildContext context) {
    return Container(
      height: 70, // Altura personalizada
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.search, Icons.search, 0),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.qr_code, Icons.qr_code, 1),
              label: 'Escanear OR',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.star_border, Icons.star_border, 2),
              label: 'Favoritos',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey[600],
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          elevation: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Muestra diálogo de confirmación
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('¿Cerrar aplicación?'),
            content: Text('¿Estás seguro de que quieres salir?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Salir'),
              ),
            ],
          ),
        );

        if (shouldExit ?? false) {
          SystemNavigator.pop(); // Cierra la app
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('BiblioApp ULima'),
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: _appmenu(context),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: _bottomNavbar(context),
      ),
    );
  }
}
