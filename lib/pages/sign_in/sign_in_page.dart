import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  SignInController control = Get.put(SignInController());

  Widget _background(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color:
                Theme.of(
                  context,
                ).colorScheme.onSecondary, // Color de la primera mitad
          ),
        ),
        Expanded(
          child: Container(
            color:
                Theme.of(
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
                'INGRESA ESTA INFORMACIÓN',
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
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No tienes una cuenta'),
                  Text(
                    ', creala aquí',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
          errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace? stackTrace,
          ) {
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
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom > 0 ? 20 : 150,
        ),
        _footer(context),
      ],
    );
  }

  Widget _footer(BuildContext context) {
    return Padding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Olvidaste tu contraseña?'),
          Text(
            ', Recupérala aquí',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      padding: EdgeInsetsGeometry.all(10),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _background(context),
          SingleChildScrollView(
            child: SizedBox(
              // Asegura que ocupe toda la altura
              height: MediaQuery.of(context).size.height,
              child: _foreground(context),
            ),
          ),
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
