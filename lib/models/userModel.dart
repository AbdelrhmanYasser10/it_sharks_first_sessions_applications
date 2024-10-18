class UserModel{
  late String userId;
  late String email;
  late String imageLink;
  late String username;


  UserModel({
    required this.email,
    required this.username,
    required this.imageLink,
    required this.userId ,
    });

  UserModel.fromJson(Map<String,dynamic>json){
    email = json["email"];
    username = json["username"];
    imageLink= json["imageLink"];
    userId = json["userId"];
  }

  Map<String,dynamic> toMap(){
    return {
      "email":email,
      "username":username,
      "userId":userId,
      "imageLink":imageLink,
    };
  }


}