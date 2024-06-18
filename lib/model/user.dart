// ignore_for_file: non_constant_identifier_names, unused_local_variable

class User {
  int id = 0;
  String user_id = "";
  String displayname = "";
  String statusMessage = "";
  String creat_time = "";
  String accessToken = "";
  String imgUrl = "";
  int point = 0;

  //  int ? user_id;
  //  String username ="";
  //  String password="";
  //  DateTime creat_time= "" as DateTime;
  //  String firstname="";
  //  String lastname="";
  //  int point= 0;

  User();

  User.FromJson(Map < String, dynamic > json, this.user_id, this.displayname, this.statusMessage, this.creat_time, this.accessToken, this.imgUrl) {
    user_id = json['user_id'];
    displayname = json['displayname'];
    accessToken = json['accessToken'];
    imgUrl = json['imgUrl'];
    int point = 0;
  }
}