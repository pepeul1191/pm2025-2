import 'package:biblioapp/configs/generic_response.dart';

class UserService {
  GenericResponse<dynamic> signIn(String user, String password) {
    // validar que no esté vacíos
    if (user.isEmpty || password.isEmpty) {
      return GenericResponse<String>(
        success: false,
        data: null,
        message: "Los campos no pueden estar vacíos",
        error: "Los campos no pueden estar vacíos",
      );
    }

    if (user == 'admin' && password == '123') {
      return GenericResponse<String>(
        success: true,
        data: "Datos de ejemplo",
        message: "Operación exitosa",
      );
    } else {
      return GenericResponse<String>(
        success: false,
        data: null,
        message: "Usuario y contraseña incorrectos",
        error: "SQL not record found",
      );
    }
  }
}
