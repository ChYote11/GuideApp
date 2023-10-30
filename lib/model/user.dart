// ignore_for_file: non_constant_identifier_names

import 'package:provider/provider.dart';

class User {

  int user_id="" as int;
  String username="";
  String password="";
  DateTime creat_time="" as DateTime;
  String firstname="";
  String lastname="";

  //  int ? user_id;
  //  String username ="";
  //  String password="";
  //  DateTime creat_time= "" as DateTime;
  //  String firstname="";
  //  String lastname="";
  //  int point= 0;

   User();

  // User.FromJson(Map < String, dynamic > json) {
  //   user_id = json['user_id'];
  //   username = json['username'];
  //   firstname = json['firstname'];
  //   lastname = json['lastname'];
  // }
    User.FromJson(Map < String, dynamic > json, this.user_id, this.username, this.password, this.creat_time, this.firstname, this.lastname) {
    user_id = json['user_id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }
}