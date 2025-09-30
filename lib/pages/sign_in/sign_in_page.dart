import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  SignInController control = Get.put(SignInController());

  SignInPage({super.key});
  
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
                'INGRESA ESTA INFORMACIÓN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              // Campo de usuario
              TextFormField(
                controller: control.username,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: UnderlineInputBorder(), // Borde inferior por defecto
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              // Campo de contraseña
              TextFormField(
                controller: control.password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: UnderlineInputBorder(), // Borde inferior por defecto
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Text(
                  control.message.value,
                  style: TextStyle(
                    color:
                        control.success.value
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Botón de login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await control.login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: const Text(
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
                  GestureDetector(
                    onTap: () async {
                      // Aquí puedes colocar el evento que quieres ejecutar cuando el texto sea tocado
                      print("Texto tocado");
                      control.goToSignUp(context);
                      // Puedes navegar a otra pantalla, abrir un diálogo, etc.
                    },
                    child: Text(
                      ', creala aquí',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        _form(context),
        SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Olvidaste tu contraseña? '),
            GestureDetector(
              onTap: () {
                // Aquí puedes colocar el evento que quieres ejecutar cuando el texto sea tocado
                control.goToResetPassword(context);
                // Puedes navegar a otra pantalla, abrir un diálogo, etc.
              },
              child: Text(
                ', Recupérala aquí',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      control.checkUserLooged(context);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}
