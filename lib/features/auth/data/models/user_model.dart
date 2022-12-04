class UserModel {
  final String name;

  const UserModel({required this.name});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(name: data['name']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
