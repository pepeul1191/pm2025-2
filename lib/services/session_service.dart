import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:biblioapp/models/user.dart';
import 'package:biblioapp/models/token.dart';

class SessionService {
  static final SessionService _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();

  static SharedPreferences? _prefs;

  // Keys para almacenamiento
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'token_data';
  static const String _isLoggedInKey = 'is_logged_in';

  // Inicializar SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Guardar User
  Future<bool> saveUser(User user) async {
    try {
      final userJson = user.toJson();
      return await _prefs!.setString(_userKey, json.encode(userJson));
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

  // Obtener User
  User? getUser() {
    try {
      final userString = _prefs!.getString(_userKey);
      if (userString != null) {
        final userMap = json.decode(userString) as Map<String, dynamic>;
        return User.fromJson(userMap);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Guardar Token
  Future<bool> saveToken(Token token) async {
    try {
      final tokenJson = token.toJson();
      return await _prefs!.setString(_tokenKey, json.encode(tokenJson));
    } catch (e) {
      print('Error saving token: $e');
      return false;
    }
  }

  // Obtener Token
  Token? getToken() {
    try {
      final tokenString = _prefs!.getString(_tokenKey);
      if (tokenString != null) {
        final tokenMap = json.decode(tokenString) as Map<String, dynamic>;
        return Token.fromJson(tokenMap);
      }
      return null;
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  // Guardar estado de login
  Future<bool> setLoggedIn(bool isLoggedIn) async {
    return await _prefs!.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Verificar si está logueado
  bool isLoggedIn() {
    return _prefs!.getBool(_isLoggedInKey) ?? false;
  }

  // Guardar ambos (User y Token) y marcar como logueado
  Future<bool> saveAuthData(User user, Token token) async {
    try {
      final userSaved = await saveUser(user);
      final tokenSaved = await saveToken(token);
      final loginSaved = await setLoggedIn(true);

      return userSaved && tokenSaved && loginSaved;
    } catch (e) {
      print('Error saving auth data: $e');
      return false;
    }
  }

  // Limpiar todos los datos (logout)
  Future<bool> clearAll() async {
    try {
      final userRemoved = await _prefs!.remove(_userKey);
      final tokenRemoved = await _prefs!.remove(_tokenKey);
      final loginRemoved = await _prefs!.remove(_isLoggedInKey);

      return userRemoved && tokenRemoved && loginRemoved;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }

  // Verificar si existe data guardada
  bool hasAuthData() {
    return getUser() != null && getToken() != null;
  }

  @override
  String toString() {
    final user = getUser();
    final token = getToken();
    final isLoggedIn = this.isLoggedIn();

    return 'SessionService{\n'
        '  isLoggedIn: $isLoggedIn,\n'
        '  hasAuthData: ${hasAuthData()},\n'
        '  user: ${user?.toString() ?? 'null'},\n'
        '  token: ${token?.toString() ?? 'null'}\n'
        '}';
  }
}
