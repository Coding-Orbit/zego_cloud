class UserModel {
  final String email;
  final String username;
  final String name;

  const UserModel({
    required this.email,
    required this.name,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        name: json['name'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'username': username,
      };
}
