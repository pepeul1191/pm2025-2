class Token {
  final String biblioapp;
  final String files;

  Token({
    required this.biblioapp,
    required this.files,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      biblioapp: json['biblioapp'] as String,
      files: json['files'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biblioapp': biblioapp,
      'files': files,
    };
  }

  @override
  String toString() {
    return 'Token{biblioapp: ${biblioapp.substring(0, 10)}..., files: ${files.substring(0, 10)}...}';
  }
}