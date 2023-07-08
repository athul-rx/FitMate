class LoginResponse{
  final int id;
  final String name;
  final String email;

  LoginResponse({required this.id, required this.name, required this.email});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
