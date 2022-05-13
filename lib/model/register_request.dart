class RegisterRequest {
  late String id;
  late String email;
  late String password;
  // String city;
  // String country;
  late String username;
  // String phoneNumber;
  // String imageUrl;

  RegisterRequest({
    required this.id,
    required this.email,
    // @required this.country,
    // @required this.imageUrl,
    required this.username,
    // @required this.phoneNumber,
  });

  toMap() {
    return {
      'id': id,
      'email': email,
      // 'password': password,
      'username': username,
      // 'phoneNumber': this.phoneNumber,
      // 'city': this.city,
      // 'country': this.country,
      // 'imageUrl': this.imageUrl,
    };
  }
}
