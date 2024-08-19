// ignore_for_file: non_constant_identifier_names

class RegistrationModel {
  final String phone;
  final String f_name;
  final String email;
  final String password;

  RegistrationModel({
    required this.phone,
    required this.f_name,
    required this.email,
    required this.password,
  });

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'f_name': f_name,
      'email': email,
      'password': password,
    };
  }

  // Factory method to create the model from JSON
  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      phone: json['phone'],
      f_name: json['f_name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
