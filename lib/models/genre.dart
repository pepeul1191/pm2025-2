class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  // Constructor fromJSON
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] as int, name: json['name'] as String);
  }

  // Método toJSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  // Método toString
  @override
  String toString() {
    return 'Genre{id: $id, name: $name}';
  }
}
