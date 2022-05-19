import 'package:flutter/cupertino.dart';

class UserModel {
  String name;
  String messageText;
  String imageUrl;
  String time;

  UserModel(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time});
}
