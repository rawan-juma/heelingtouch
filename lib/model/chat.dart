import 'package:heelingtouchproject/model/messege.dart';

class ChatRoom {
  late String id;
  late String therapistID;
  late String patientID;
//  FieldValue timeStamp;
  late String time;
  late List<dynamic> messages;
  // late String urlImage;
  // late bool isRead;

  ChatRoom({
    required this.id,
    required this.messages,
    required this.therapistID,
    required this.patientID,
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