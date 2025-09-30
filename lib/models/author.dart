class Author {
  int id;
  String fullName;
  DateTime birthDate;
  String image;

  Author({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.image,
  });

  // Constructor fromJSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      image: json['image'] as String,
    );
  }

  // Método toJSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'birth_date':
          birthDate.toIso8601String().split('T')[0], // Formato YYYY-MM-DD
      'image': image,
    };
  }

  // Método toString
  @override
  String toString() {
    return 'Author{id: $id, fullName: $fullName, birthDate: $birthDate, image: $image}';
  }
}
