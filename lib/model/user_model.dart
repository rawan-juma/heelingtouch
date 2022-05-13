// ignore_for_file: empty_constructor_bodies

class UserModel {
  late String id;
  late String phone;
  late String username;
  late String password;
  // String imageUrl;

  UserModel({
    required this.id,
    required this.phone,
    required this.username,
    required this.password,
    // @required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    id = map['id'];
    phone = map['phone'];
    username = map['username'];
    password = map['password'];
    // this.imageUrl = map['imageUrl'];
  }
  toMap() {
    return {
      'username': username,
      'phoneNumber': phone,
      'password': password,
      // 'imageUrl': this.imageUrl
    };
  }
}
