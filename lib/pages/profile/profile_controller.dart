import 'dart:io';

import 'package:biblioapp/configs/constants.dart';
import 'package:biblioapp/models/user.dart';
import 'package:biblioapp/responses/file_upload_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:biblioapp/services/session_service.dart';
import 'package:biblioapp/services/users_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  SessionService sessionService = SessionService();
  UsersService usersService = UsersService();
  final Rx<User?> user = Rx<User?>(null);
  final ImagePicker _picker = ImagePicker();

  void getUser() {
    print('1 +++++++++++++++++++++++++');
    print(sessionService);
    user.value = sessionService.getUser();
    print(user.value);
    print(BASE_URL + user.value!.profilePicture!);
    print('2 +++++++++++++++++++++++++');
  }

  void uploadImage() async {
    try {
      // Abrir la cámara y tomar una foto
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Si la imagen es seleccionada, se puede realizar cualquier operación (por ejemplo, subirla al servidor)
        print('Imagen tomada: ${image.path}');
        await _uploadImageToServer(File(image.path));
        // Aquí puedes continuar con el proceso para cargar la imagen al servidor o almacenar la ruta localmente
        // Si deseas actualizar el perfil del usuario, puedes hacerlo aquí
      } else {
        print('No se tomó ninguna imagen');
      }
    } catch (e) {
      print('Error al tomar la foto: $e');
    }
  }

  Future<void> _uploadImageToServer(File imageFile) async {
    try {
      //isLoading.value = true;

      // Obtener el token del usuario
      final currentUser = sessionService.getUser();
      final token = sessionService.getToken();

      if (currentUser == null || token == null) {
        Get.snackbar('Error', 'Usuario no autenticado');
        return;
      }

      // Subir la imagen al servidor
      final response = await usersService.uploadProfileImage(imageFile);

      if (response.success) {
        // Actualizar la foto de perfil localmente
        if (response.data != null) {
          //final newImagePath = response.data['path'];
          FileUploadResponse fileResponse = response.data;
          print('1 +++++++++++++++++++++++++++++++');
          print(fileResponse);
          print('2 +++++++++++++++++++++++++++++++');

          // Actualizar el usuario en el SessionService
          //currentUser.profilePicture = newImagePath;
          //sessionService.setUser(currentUser);

          // Actualizar el observable
          user.value = currentUser;
          if (user.value != null) {
            user.value?.profilePicture = BASE_URL + fileResponse.path;
            print(user.value);
          }
          print('3 +++++++++++++++++++++++++++++++++++++++++++');

          Get.snackbar('Éxito', 'Foto de perfil actualizada correctamente');
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Error al subir la imagen');
      }
    } catch (e) {
      print('Error al subir la imagen: $e');
      Get.snackbar('Error', 'Error al subir la imagen: $e');
    } finally {
      //isLoading.value = false;
    }
  }

  void updateProfilePhoto() {
    print('updateProfilePhoto');
  }
}
