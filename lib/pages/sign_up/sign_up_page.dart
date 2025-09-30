import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpController control = Get.put(SignUpController());

  SignUpPage({super.key});

  Widget _background(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color:
                Theme.of(
                  context,
                ).colorScheme.onPrimaryContainer, // Color de la primera mitad
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white, // Color de la segunda mitad
          ),
        ),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 50,
        right: 50,
      ), // padding: 20px 30px 20px 10px;
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              // Subtítulo
              Text(
                'CREAR CUENTA',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              // Campo de usuario
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: UnderlineInputBorder(), // Borde inferior por defecto
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              // Campo de contraseña
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: UnderlineInputBorder(), // Borde inferior por defecto
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repita Contraseña',
                  border: UnderlineInputBorder(), // Borde inferior por defecto
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              // Campo de correo
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: UnderlineInputBorder(), // Borde inferior por defecto
                  prefixIcon: const Icon(Icons.mail),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Botón de login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: const Text(
                    'CREAR CUENTA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backbutton(BuildContext context){
    return Padding(padding: EdgeInsets.all(20), child: GestureDetector(
      onTap: () {
        // Aquí puedes colocar el evento que quieres ejecutar cuando el texto sea tocado
        print("Texto tocado");
        Navigator.of(context).pop();
        // Puedes navegar a otra pantalla, abrir un diálogo, etc.
      },
      child: Icon(
        Icons.arrow_back, // Icono de flecha hacia atrás
        color: Theme.of(context).primaryColor,
        size: 24, // Tamaño del icono (opcional)
      ),
    ),);
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        _form(context),
        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _background(context),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: _foreground(context),
            ),
          ),
          _backbutton(context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}
