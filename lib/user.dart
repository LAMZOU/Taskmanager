class UserProfile {
  final String nom;
  final String prenom;
  final String email;
  final String? password;  // Le mot de passe ne devrait pas être stocké en clair.
  final String? photo;

  UserProfile({
    required this.nom,
    required this.prenom,
    required this.email,
    this.password,
    this.photo,
  });

  // Convertir de JSON à UserProfile
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      password: json['password'],
      photo: json['photo'],
    );
  }

  // Convertir de UserProfile à JSON
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'photo': photo,
    };
  }
}
