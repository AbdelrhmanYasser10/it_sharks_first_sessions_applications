import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  late String content;
  late String recId;
  late String senderId;
  late Timestamp time;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.recId,
    required  this.time
});

  MessageModel.fromJson(Map<String,dynamic> json){
    content = json["content"];
    recId = json["recId"];
    senderId = json["senderId"];
    time = json["time"];
  }

  Map<String,dynamic> toMap()=>{
    "content":content,
    "recId":recId,
    "senderId":senderId,
    "time":time,
  };
}