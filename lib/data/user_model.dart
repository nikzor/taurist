class UserModel {
  late String id;
  late String name;
  late String email;
  late String password;
  late String avatar;
  late String about;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
    required this.about,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      about: json['about'],
    );
  }
}
