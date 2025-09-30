import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/models/tokens.dart';
import 'package:biblioapp/models/user.dart';

class LoginResponse {
  final User user;
  final Tokens tokens;

  LoginResponse({
    required this.user,
    required this.tokens,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tokens': tokens.toJson(),
    };
  }

  @override
  String toString() {
    return 'LoginResponse{user: $user, tokens: $tokens}';
  }
}