import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zero/models/Message.dart';
import 'package:animations/animations.dart';
import 'package:zero/helpers.dart';
import 'package:zero/models/ModelProvider.dart';
import 'package:zero/models/User.dart';

class ChatScreen extends StatefulWidget {
  String username;
  String imageUrl;

  ChatScreen({Key? key, required this.username, required this.imageUrl})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String senderID = '';
  String senderUsername = '';
  String receiverID = '';
  String receiverUsername = '';

  Future<void> _initialSetup() async {
    Amplify.Auth.getCurrentUser().then((value) {
      senderID = value.userId;
      senderUsername = value.username;
    });
    final result = await Amplify.DataStore.query(User.classType,
        where: User.USERNAME.eq(widget.username));
    receiverID = result[0].id;
    receiverUsername = result[0].username;

    final chats = await Amplify.DataStore.query(Chat.classType,
        where: Chat.FROM.eq(senderUsername).and(Chat.TO.eq(receiverUsername)));
    if (chats.isEmpty) {
      Amplify.DataStore.save(new Chat(
          userID: senderID, from: senderUsername, to: receiverUsername));
    }
  }

  @override
  void initState() {
    super.initState();
    _initialSetup();
  }

  void _handleSubmitted(String text) async {
    _textController.clear();

    setState(() {
      Amplify.DataStore.save(new Message(
          content: text,
          senderID: senderID,
          receiverID: receiverID,
          seenByReceiver: false));
    });

    _focusNode.requestFocus();
  }

  Future<List<Message>> getMessages() async {
    if (senderID == '' || receiverID == '') {
      await _initialSetup();
    }
    final messages = await Amplify.DataStore.query(Message.classType,
        where: Message.SENDERID
            .eq(senderID)
            .and(Message.RECEIVERID.eq(receiverID)));

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
            child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),
            const SizedBox(width: 2),
            CircleAvatar(
              backgroundImage: Image.asset(widget.imageUrl).image,
              maxRadius: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.username,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 13),
                )
              ],
            )),
          ]),
        )),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<Message>>(
              future: getMessages(),
              builder: (context, future) {
                if (!future.hasData || future.data!.isEmpty) {
                  return Center(
                      heightFactor: 30,
                      child: Text('Just make the first step:)',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w200)));
                } else {
                  final messages = future.data;

                  return ListView.builder(
                    itemCount: messages!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 70),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].receiverID == senderID
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].receiverID == senderID
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              messages[index].content ?? '',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                    child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black45),
                      border: InputBorder.none),
                )),
                const SizedBox(width: 15),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.send_outlined,
                      color: Colors.white, size: 20),
                  backgroundColor: Colors.lightBlue,
                  elevation: 0,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
