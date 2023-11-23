class User {
  String email;
  String password;

  String token;

  User({required this.email, required this.password, required this.token});

  // now create converter

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      email: responseData['email'],
      password: responseData['phone'],
      token: responseData['token'],
    );
  }
}
