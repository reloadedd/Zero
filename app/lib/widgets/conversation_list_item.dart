import 'package:flutter/material.dart';
import 'package:zero/screens/chat.dart';

class ConversationListItem extends StatefulWidget {
  String username;
  String lastMessage;
  String profilePictureUrl;
  String createdOn;
  bool isMessageRead;

  ConversationListItem(
      {Key? key,
      required this.username,
      required this.lastMessage,
      required this.profilePictureUrl,
      required this.createdOn,
      required this.isMessageRead})
      : super(key: key);

  @override
  State<ConversationListItem> createState() => _ConversationListItemState();
}

class _ConversationListItemState extends State<ConversationListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatScreen(
            username: widget.username,
            imageUrl: widget.profilePictureUrl,
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
                  backgroundImage: Image.asset(widget.profilePictureUrl).image,
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
                        widget.username,
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
              widget.createdOn,
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
