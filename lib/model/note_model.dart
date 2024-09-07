class NoteModel{
  int? id;
  late String title;
  late String desc;
  late String date;
  late int status;

  NoteModel({
   this.id,
   required this.title,
   required this.desc,
   required this.date,
   required this.status,
  });

  NoteModel.fromMap(Map<String,dynamic> map){
    id = map["id"];
    desc = map["desc"];
    title = map["title"];
    date = map["date"];
    status = map["status"];
  }

  Map<String ,dynamic> toMap(){
    return {
      "id":id,
      "desc":desc,
      "title":title,
      "date":date,
      "status":status,
    };
  }
}