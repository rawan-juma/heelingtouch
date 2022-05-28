class MessageModel {
  late String content;
  late String senderId;
  late String recieverId;
//  FieldValue timeStamp;
  late String hour;
  // late String urlImage;
  // late bool isRead;

  MessageModel({
    required this.content,
    required this.recieverId,
    required this.senderId,
    //   required this.timeStamp,
    required this.hour,
    // required this.urlImage,
    // required this.isRead,
  });
  MessageModel.fromJson(Map map) {
    content = map['content'];
    senderId = map['senderId'];
    recieverId = map['recieverId'];
    hour = map['hour'];
    // urlImage = map['urlImage'];
    // isRead = map['read'];
  }
  toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'recieverId': recieverId,
      //  'timeStamp': timeStamp,
      'hour': hour,
      // 'urlImage': urlImage,
      // 'read': isRead,
    };
  }
}
