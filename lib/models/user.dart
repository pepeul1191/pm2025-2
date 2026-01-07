class User {
  final int id;
  final String username;
  final String firstNames;
  final String lastNames;
  final String email;
  String? profilePicture;
  final bool sex;
  final DateTime? birthDate;
  final String? resetKey;
  final int? countryId;

  User({
    required this.id,
    required this.username,
    required this.firstNames,
    required this.lastNames,
    required this.email,
    this.profilePicture,
    required this.sex,
    this.birthDate,
    this.resetKey,
    this.countryId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      firstNames: json['first_names'] as String,
      lastNames: json['last_names'] as String,
      email: json['email'] as String,
      profilePicture: json['profile_picture'] as String?,
      sex: json['sex'] as bool,
      birthDate:
          json['birth_date'] != null
              ? DateTime.parse(json['birth_date'] as String)
              : null,
      resetKey: json['reset_key'] as String?,
      countryId: json['country_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_names': firstNames,
      'last_names': lastNames,
      'email': email,
      'profile_picture': profilePicture,
      'sex': sex,
      'birth_date': birthDate?.toIso8601String(),
      'reset_key': resetKey,
      'country_id': countryId,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, firstNames: $firstNames, lastNames: $lastNames, email: $email, profilePicture: $profilePicture}';
  }
}
