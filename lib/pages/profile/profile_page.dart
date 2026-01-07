import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/models/user.dart' show User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfileController control = Get.put(ProfileController());

  ProfilePage({super.key});

  Widget _buildBody(BuildContext context) {
    return _foreground(context);
  }

  Widget _foreground(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80),
        Obx(() {
          final user = control.user.value;
          final profilePictureUrl = user?.profilePicture;

          String imageUrl;
          if (profilePictureUrl == null || profilePictureUrl.isEmpty) {
            // Imagen por defecto
            return Image.asset(
              'assets/images/ulises.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            );
          } else {
            // Imagen del usuario
            imageUrl = profilePictureUrl;
            return Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value:
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                  ),
                );
              },
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                // Si falla la carga, mostrar imagen por defecto
                return Image.asset(
                  'assets/images/ulises.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                );
              },
            );
          }
        }),
        // Botón para cambiar foto (separado)
        SizedBox(height: 16),
        ElevatedButton.icon(
          icon: Icon(Icons.camera_alt),
          label: Text('Cambiar foto'),
          onPressed: control.uploadImage,
        ),
      ],
    );
  }

  PreferredSizeWidget _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Editar Perfil',
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSecondary, // Color de la flecha
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    control.getUser();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbar(context),
      body: _buildBody(context),
    );
  }
}
