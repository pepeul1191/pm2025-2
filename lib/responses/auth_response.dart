import 'package:biblioapp/models/token.dart';
import 'package:biblioapp/models/user.dart';

class AuthResponse {
  final User user;
  final Token tokens;

  AuthResponse({required this.user, required this.tokens});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: Token.fromJson(json['tokens'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'tokens': tokens.toJson()};
  }

  @override
  String toString() {
    return 'AuthResponse{user: $user, tokens: $tokens}';
  }
}
