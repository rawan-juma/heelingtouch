class Notifications {
  late String id;
  late String therapistID;
  late String patientID;
  late String therapistImage;
  late String patientImage;
  late String therapistName;
  late String patientName;
  // late String content;
  late int day;
  Notifications(
      {required this.id,
      required this.therapistID,
      required this.patientID,
      required this.therapistImage,
      required this.patientImage,
      required this.therapistName,
      required this.patientName,
      // required this.content,
      required this.day});
}
