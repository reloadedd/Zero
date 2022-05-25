import 'package:flutter/material.dart';
import 'package:zero/models/user.dart';
import 'package:zero/screens/chat.dart';
import 'package:zero/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationList extends StatefulWidget {
  String name;
  String lastMessage;
  String imageUrl;
  String time;
  bool isMessageRead;

  ConversationList(
      {Key? key,
      required this.name,
      required this.lastMessage,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead})
      : super(key: key);

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatScreen(
            name: widget.name,
            imageUrl: widget.imageUrl,
          );
        }));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: Image.asset(widget.imageUrl).image,
                  maxRadius: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(widget.lastMessage,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade900,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.normal
                                  : FontWeight.bold)),
                    ],
                  ),
                ))
              ],
            )),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.normal
                      : FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<UserModel> users = [
    UserModel(
        name: "Jane Russel",
        lastMessage: "Awesome Setup",
        imageUrl: "assets/images/userImage1.jpeg",
        time: "Now"),
    UserModel(
        name: "Glady's Murphy",
        lastMessage: "That's Great",
        imageUrl: "assets/images/userImage2.jpeg",
        time: "Yesterday"),
    UserModel(
        name: "Jorge Henry",
        lastMessage: "Hey where are you?",
        imageUrl: "assets/images/userImage3.jpeg",
        time: "31 Mar"),
    UserModel(
        name: "Philip Fox",
        lastMessage: "Busy! Call me in 20 mins",
        imageUrl: "assets/images/userImage4.jpeg",
        time: "28 Mar"),
    UserModel(
        name: "Debra Hawkins",
        lastMessage: "Thank you, It's awesome",
        imageUrl: "assets/images/userImage5.jpeg",
        time: "23 Mar"),
    UserModel(
        name: "Jacob Pena",
        lastMessage: "will update you in evening",
        imageUrl: "assets/images/userImage6.jpeg",
        time: "17 Mar"),
    UserModel(
        name: "Andrey Jones",
        lastMessage: "Can you please share the file?",
        imageUrl: "assets/images/userImage7.jpeg",
        time: "24 Feb"),
    UserModel(
        name: "John Wick",
        lastMessage: "How are you?",
        imageUrl: "assets/images/userImage8.jpeg",
        time: "18 Feb"),
  ];

  Future<void> setSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(G_APP_OPENEND_FIRST_TIME, false);
  }

  @override
  void initState() {
    super.initState();
    setSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Messages",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                      Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.purple.shade700),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.purple,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Add new",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search (or don't)...",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.grey.shade400, size: 20),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100))),
              )),
          ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ConversationList(
                name: users[index].name,
                lastMessage: users[index].lastMessage,
                imageUrl: users[index].imageUrl,
                time: users[index].time,
                isMessageRead: (index == 0 || index == 3) ? true : false,
              );
            },
          ),
        ],
      ),
    ));
  }
}
