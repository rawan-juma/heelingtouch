// ignore_for_file: empty_constructor_bodies

class UserModel {
  late String id;
  late String userID;
  late String phone;
  late String username;
  late String address;
  late String age;
  // late String password;
  late String imageUrl;

  UserModel({
    required this.id,
    required this.userID,
    required this.phone,
    required this.username,
    required this.address,
    required this.age,
    // required this.password,
    required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    id = map['id'];
    phone = map['phone'];
    username = map['username'];
    username = map['address'];
    username = map['age'];
    // password = map['password'];
    imageUrl = map['imageUrl'];
  }
  toMap() {
    return {
      'username': username,
      'phoneNumber': phone,
      // 'password': password,
      'imageUrl': this.imageUrl
    };
  }
}
