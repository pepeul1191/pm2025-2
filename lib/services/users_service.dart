import 'package:biblioapp/configs/generic_response.dart';

class UsersService {
  GenericResponse<dynamic> signIn(String user, String password) {
    if (user == '' || password == '') {
      return GenericResponse(
        success: false,
        data: null,
        message: "Debe de ingresar usuario y contraseña",
        error: "ERROR!",
      );
    }
    if (user == 'admin' && password == '123') {
      return GenericResponse(
        success: true,
        data: null,
        message: "Vamos bien",
        error: null,
      );
    } else {
      return GenericResponse(
        success: false,
        data: null,
        message: "Usuario y contraseña no válidos",
        error: "ERROR!",
      );
    }
  }
}
