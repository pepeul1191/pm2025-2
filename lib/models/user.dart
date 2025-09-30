class User {
  final int id;
  final String username;
  final String? password; // Opcional
  final String firstNames;
  final String lastNames;
  final String email;
  final DateTime? birthDate; // Opcional
  final String? profilePicture;
  final bool sex;
  final String? resetKey; // Opcional
  final int? countryId; // Opcional

  User({
    required this.id,
    required this.username,
    this.password,
    required this.firstNames,
    required this.lastNames,
    required this.email,
    this.birthDate, // Ahora opcional
    this.profilePicture,
    required this.sex,
    this.resetKey,
    this.countryId,
  });

  // Constructor from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String?,
      firstNames: json['first_names'] as String,
      lastNames: json['last_names'] as String,
      email: json['email'] as String,
      birthDate: json['birth_date'] != null 
          ? DateTime.parse(json['birth_date'] as String)
          : null,
      profilePicture: json['profile_picture'] as String?,
      sex: (json['sex'] as bool?) ?? false,
      resetKey: json['reset_key'] as String?,
      countryId: json['country_id'] as int?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'first_names': firstNames,
      'last_names': lastNames,
      'email': email,
      'birth_date': birthDate?.toIso8601String().split('T')[0],
      'profile_picture': profilePicture,
      'sex': sex,
      'reset_key': resetKey,
      'country_id': countryId,
    };
  }

  // Copy with method for updates
  User copyWith({
    int? id,
    String? username,
    String? password,
    String? firstNames,
    String? lastNames,
    String? email,
    DateTime? birthDate,
    String? profilePicture,
    bool? sex,
    String? resetKey,
    int? countryId,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      firstNames: firstNames ?? this.firstNames,
      lastNames: lastNames ?? this.lastNames,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      profilePicture: profilePicture ?? this.profilePicture,
      sex: sex ?? this.sex,
      resetKey: resetKey ?? this.resetKey,
      countryId: countryId ?? this.countryId,
    );
  }

  // Método toString mejorado
  @override
  String toString() {
    return 'User: $firstNames $lastNames ($email) - Username: $username';
  }
}