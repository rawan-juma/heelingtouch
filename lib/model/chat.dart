class ChatRoom {
  late String id;
  late String therapistID;
  late String patientID;
  late String patientName;
  late String therapistName;
  late String patientImg;
  late String therapistImg;
  late String patientPhone;
  late String therapistPhone;
//  FieldValue timeStamp;
  late int time;
  late List<dynamic> messages;
  // late String urlImage;
  // late bool isRead;

  ChatRoom({
    required this.id,
    required this.messages,
    required this.therapistID,
    required this.patientID,
    required this.patientName,
    required this.therapistName,
    required this.patientImg,
    required this.therapistImg,
    required this.patientPhone,
    required this.therapistPhone,
    //   required this.timeStamp,
    required this.time,
    // required this.urlImage,
    // required this.isRead,
  });
  ChatRoom.fromJson(Map map) {
    messages = map['messages'];
    therapistID = map['therapistID'];
    patientID = map['patientID'];
    time = map['time'];
    // urlImage = map['urlImage'];
    // isRead = map['read'];
  }
  toJson() {
    return {
      'messages': messages,
      'therapistID': therapistID,
      'patientID': patientID,
      //  'timeStamp': timeStamp,
      'time': time,
      // 'urlImage': urlImage,
      // 'read': isRead,
    };
  }
}
