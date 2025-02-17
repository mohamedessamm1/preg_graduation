class MessageModel {
  String? sender;
  String? dateTime;
  String? text;

  MessageModel({
    this.sender,
    this.dateTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    sender = json?['sender'];
    dateTime = json?['dateTime'];
    text = json?['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
