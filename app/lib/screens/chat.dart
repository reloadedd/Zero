import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zero/models/message.dart';

// String _name = 'reloadedd';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
//   final _textController = TextEditingController();
//   final List<ChatMessage> _messages = [];
//   final FocusNode _focusNode = FocusNode();
//   bool _isComposing = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Zero'),
//           elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0 : 4,
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               Flexible(
//                   child: ListView.builder(
//                 itemBuilder: (_, index) => _messages[index],
//                 padding: const EdgeInsets.all(8),
//                 reverse: true,
//                 itemCount: _messages.length,
//               )),
//               const Divider(height: 1),
//               Container(
//                 decoration: BoxDecoration(color: Theme.of(context).cardColor),
//                 child: _buildTextComposer(),
//               )
//             ],
//           ),
//           decoration: Theme.of(context).platform == TargetPlatform.iOS
//               ? BoxDecoration(
//                   border: Border(top: BorderSide(color: Colors.grey[200]!)))
//               : null,
//         ));
//   }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     setState(() {
//       _isComposing = false;
//     });

//     ChatMessage message = ChatMessage(
//       text: text,
//       animationController: AnimationController(
//         duration: const Duration(milliseconds: 700),
//         vsync: this,
//       ),
//     );

//     setState(() {
//       _messages.insert(0, message);
//     });
//     _focusNode.requestFocus();
//     message.animationController.forward();
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           children: [
//             Flexible(
//                 child: TextField(
//               controller: _textController,
//               onSubmitted: _isComposing ? _handleSubmitted : null,
//               onChanged: (text) {
//                 setState(() {
//                   _isComposing = text.isNotEmpty;
//                 });
//               },
//               decoration:
//                   const InputDecoration.collapsed(hintText: 'Send a message'),
//               focusNode: _focusNode,
//             )),
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: Theme.of(context).platform == TargetPlatform.iOS
//                     ? CupertinoButton(
//                         child: const Text('Send'),
//                         onPressed: _isComposing
//                             ? () => _handleSubmitted(_textController.text)
//                             : null)
//                     : IconButton(
//                         icon: const Icon(Icons.send),
//                         onPressed: _isComposing
//                             ? () => _handleSubmitted(_textController.text)
//                             : null,
//                       ))
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     for (var message in _messages) {
//       message.animationController.dispose();
//     }
//     super.dispose();
//   }
// }

// class ChatMessage extends StatelessWidget {
//   const ChatMessage(
//       {required this.text, required this.animationController, Key? key})
//       : super(key: key);
//   final String text;
//   final AnimationController animationController;

//   @override
//   Widget build(BuildContext context) {
//     return SizeTransition(
//       sizeFactor: CurvedAnimation(
//         parent: animationController,
//         curve: Curves.elasticOut,
//       ),
//       axisAlignment: 0,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(right: 16),
//               child: CircleAvatar(child: Text(_name[0])),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _name,
//                     style: Theme.of(context).textTheme.headline4,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5.0),
//                     child: Text(text),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class ChatScreen extends StatefulWidget {
  String name;
  String imageUrl;

  ChatScreen({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messages = [
    MessageModel(content: "Hi there", type: "receiver"),
    MessageModel(content: "Hello", type: "sender"),
    MessageModel(content: "Do you have a spare bitcoin?", type: "receiver"),
    MessageModel(content: "Nah man, just ran out of 'em...", type: "sender"),
  ];

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
                Text(widget.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 13),
                )
              ],
            )),
            const Icon(
              Icons.settings,
              color: Colors.black45,
            )
          ]),
        )),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 70),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].type == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].type == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      messages[index].content,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
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
                const Expanded(
                    child: TextField(
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
