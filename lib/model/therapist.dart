class Therapist {
  late String id;
  late String therapistID;
  late String fName;
  late String lName;
  late String bio;
  late String phonenumber;
  late String img;
  late bool status;
  late String email;

  Therapist(
      {required this.id,
      required this.therapistID,
      required this.fName,
      required this.lName,
      required this.bio,
      required this.phonenumber,
      required this.img,
      required this.status,
      required this.email});
}
