import 'package:flutter/cupertino.dart';

class UserModel {
  String name;
  String lastMessage;
  String imageUrl;
  String time;

  UserModel(
      {required this.name,
      required this.lastMessage,
      required this.imageUrl,
      required this.time});
}
