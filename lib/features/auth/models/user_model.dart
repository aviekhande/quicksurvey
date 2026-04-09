class UserModel {
  final String phone;
  final String password;

  UserModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phone: json['phone'] as String,
        password: json['password'] as String,
      );
}
