class Publisher {
  int id;
  String name;
  String logo;

  Publisher({required this.id, required this.name, required this.logo});

  // Constructor fromJSON
  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
    );
  }

  // Método toJSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'logo': logo};
  }

  // Método toString
  @override
  String toString() {
    return 'Publisher{id: $id, name: $name, logo: $logo}';
  }
}
