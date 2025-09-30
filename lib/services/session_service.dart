// services/shared_preferences_service.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:biblioapp/models/user.dart';
import 'package:biblioapp/models/tokens.dart';

class SessionService {
  static final SessionService _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();

  static SharedPreferences? _prefs;

  // Keys para almacenamiento
  static const String _userKey = 'current_user';
  static const String _tokensKey = 'user_tokens';
  static const String _isLoggedInKey = 'is_logged_in';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Guardar usuario
  Future<void> saveUser(User user) async {
    if (_prefs == null) await init();
    final userJson = user.toJson();
    await _prefs!.setString(_userKey, json.encode(userJson));
    await _prefs!.setBool(_isLoggedInKey, true);
  }

  // Obtener usuario
  User? getUser() {
    if (_prefs == null) return null;
    final userJsonString = _prefs!.getString(_userKey);
    if (userJsonString != null) {
      final Map<String, dynamic> userMap = json.decode(userJsonString);
      return User.fromJson(userMap);
    }
    return null;
  }

  // Guardar tokens
  Future<void> saveTokens(Tokens tokens) async {
    if (_prefs == null) await init();
    final tokensJson = tokens.toJson();
    await _prefs!.setString(_tokensKey, json.encode(tokensJson));
  }

  // Obtener tokens
  Tokens? getTokens() {
    if (_prefs == null) return null;
    final tokensJsonString = _prefs!.getString(_tokensKey);
    if (tokensJsonString != null) {
      final Map<String, dynamic> tokensMap = json.decode(tokensJsonString);
      return Tokens.fromJson(tokensMap);
    }
    return null;
  }

  // Verificar si está logueado
  bool get isLoggedIn {
    if (_prefs == null) return false;
    return _prefs!.getBool(_isLoggedInKey) ?? false;
  }

  // Obtener token de autenticación
  String? get authToken {
    final tokens = getTokens();
    return tokens?.biblioapp;
  }

  // Cerrar sesión
  Future<void> logout() async {
    if (_prefs == null) await init();
    await _prefs!.remove(_userKey);
    await _prefs!.remove(_tokensKey);
    await _prefs!.setBool(_isLoggedInKey, false);
  }

  // Limpiar todo
  Future<void> clearAll() async {
    if (_prefs == null) await init();
    await _prefs!.clear();
  }

  @override
  String toString() {
    final user = getUser();
    final tokens = getTokens();
    return 'SessionService{isLoggedIn: $isLoggedIn, user: $user, hasTokens: ${tokens != null}, authToken: ${authToken != null ? "${authToken!.substring(0, 10)}..." : "null"}}';
  }
}