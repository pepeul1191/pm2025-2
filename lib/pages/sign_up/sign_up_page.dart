import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpController control = Get.put(SignUpController());

  Widget _background(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(
              context,
            ).colorScheme.onSecondary, // Color de la primera mitad
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(
              context,
            ).colorScheme.surfaceDim, // Color de la segunda mitad
          ),
        ),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 50, right: 50),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 15),
              // Subtítulo
              Text(
                'CREAR CUENTA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 15),
              // Campo de usuario
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: UnderlineInputBorder(
                    // Solo borde inferior
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    // Borde cuando está habilitado
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    // Borde cuando está enfocado
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.person), // Icono al inicio
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 0,
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Campo de contraseña
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: UnderlineInputBorder(
                    // Solo borde inferior
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    // Borde cuando está habilitado
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    // Borde cuando está enfocado
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock), // Icono al inicio
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 0,
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Campo de contraseña
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repetir contraseña',
                  border: UnderlineInputBorder(
                    // Solo borde inferior
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    // Borde cuando está habilitado
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    // Borde cuando está enfocado
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock), // Icono al inicio
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 0,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: UnderlineInputBorder(
                    // Solo borde inferior
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    // Borde cuando está habilitado
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    // Borde cuando está enfocado
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.email), // Icono al inicio
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 0,
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Botón de login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    'CREAR CUENTA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _foreground(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80),
        Image.network(
          'https://40729136-0daa-4be7-bbf2-5c64410ef3aa-00-2d22h14xb93qv.worf.replit.dev/images/ulises-web.png',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
                // Este widget se muestra cuando ocurre un error al cargar la imagen de red.
                return Image.asset(
                  'assets/images/ulises.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 20.0,
            bottom: 20.0,
          ), // Margen superior de 20
          child: Text(
            'BiblioApp ULima',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        _form(context),
      ],
    );
  }

  Widget _backbutton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            padding: EdgeInsets.all(8),
            minimumSize: Size(40, 40),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _background(context),
          SingleChildScrollView(child: _foreground(context)),
          _backbutton(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite que la interfaz se redimensione
      appBar: null,
      body: _buildBody(context),
    );
  }
}
