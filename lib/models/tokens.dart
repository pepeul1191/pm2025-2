class Tokens {
  final String biblioapp;

  Tokens({
    required this.biblioapp,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      biblioapp: json['biblioapp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biblioapp': biblioapp,
    };
  }

  @override
  String toString() {
    return 'Tokens{biblioapp: $biblioapp}';
  }
}