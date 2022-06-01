import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zero/constants.dart';
import 'package:zero/models/ModelProvider.dart';
import 'package:zero/screens/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MessageType { SENDER, RECEIVER }

String SEED_PHASE = '';

class MessageModel {
  String content;
  MessageType type;

  MessageModel({required this.content, required this.type});
}

class SeedPhraseConfirmationScreen extends StatefulWidget {
  final String seedPhrase;
  final List<String> seedPhraseSplitted;

  SeedPhraseConfirmationScreen(
      {Key? key, required this.seedPhraseSplitted, required this.seedPhrase})
      : super(key: key);

  @override
  State<SeedPhraseConfirmationScreen> createState() =>
      _SeedPhraseConfirmationScreenState();
}

class _SeedPhraseConfirmationScreenState
    extends State<SeedPhraseConfirmationScreen> {
  List<MessageModel> messages = [
    MessageModel(
        content:
            'Please enter the seed phase\'s words in the same order as they were given',
        type: MessageType.RECEIVER)
  ];

  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  int _currentWordIndex = 0;

  @override
  void initState() {
    super.initState();
    SEED_PHASE = widget.seedPhrase;
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    setState(() {
      messages.add(MessageModel(content: text, type: MessageType.SENDER));
      Timer(
          Duration(milliseconds: 300),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    });

    print('DEBUG: ${text} | ${widget.seedPhraseSplitted[_currentWordIndex]}');
    if (text != widget.seedPhraseSplitted[_currentWordIndex]) {
      setState(() {
        messages.add(MessageModel(
            content: 'Word ${_currentWordIndex + 1}: ❌',
            type: MessageType.RECEIVER));
        Timer(
            Duration(milliseconds: 300),
            () => _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent));
      });
    } else {
      setState(() {
        messages.add(MessageModel(
            content: 'Word ${_currentWordIndex + 1}: ✅',
            type: MessageType.RECEIVER));
        _currentWordIndex++;
      });
    }

    if (_currentWordIndex == 2) {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SeedPhraseSuccessScreen();
          // return MessagesPage();
        }));
      });
    }

    _focusNode.requestFocus();
    // message.animationController.forward();
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
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: Image.asset('assets/icon/icon.png').image,
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
                Text('Zero',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 13),
                )
              ],
            ))
          ]),
        )),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 5, bottom: 5),
                child: Align(
                  alignment: (messages[index].type == MessageType.RECEIVER
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].type == MessageType.RECEIVER
                          ? Colors.red.withAlpha(20)
                          : Colors.lightBlueAccent),
                    ),
                    padding: EdgeInsets.all(16),
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
              height: 65,
              width: double.infinity,
              color: Colors.white,
              child: Row(children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  onSubmitted: _isComposing ? _handleSubmitted : null,
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Write just one word...",
                      hintStyle: TextStyle(color: Colors.black45)),
                )),
                const SizedBox(width: 5),
                FloatingActionButton(
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                  child: const Icon(Icons.send_outlined,
                      color: Colors.white, size: 20),
                  backgroundColor: Colors.lightBlueAccent,
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

class SeedPhraseSuccessScreen extends StatefulWidget {
  const SeedPhraseSuccessScreen({Key? key}) : super(key: key);

  @override
  State<SeedPhraseSuccessScreen> createState() =>
      _SeedPhraseSuccessScreenState();
}

class _SeedPhraseSuccessScreenState extends State<SeedPhraseSuccessScreen> {
  List<MessageModel> messages = [
    MessageModel(
        content: 'Congratulations! You\'ve entered the seed phrase correctly!',
        type: MessageType.RECEIVER),
    MessageModel(
        content: '❗Make sure to keep it safe 🔒', type: MessageType.RECEIVER),
    MessageModel(
        content: 'Now, you are truly ready! Let\'s rock 🚀',
        type: MessageType.RECEIVER),
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
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: Image.asset('assets/icon/icon.png').image,
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
                Text('Zero',
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
          ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 70),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 5, bottom: 5),
                    child: Align(
                        alignment: (Alignment.topLeft),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Text(messages[index].content,
                              style: const TextStyle(fontSize: 15)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red.withAlpha(20)),
                        )));
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                width: double.infinity,
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (SEED_PHASE != '') {
                      prefs.setBool(G_APP_OPENEND_FIRST_TIME, false);
                      prefs.setString(G_SEED_PHASE, SEED_PHASE);
                    } else {
                      print('ERROR\tUnable to save seed phase locally!');
                      throw Exception('That\'s bad!');
                    }

                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return MessagesPage();
                    }));
                  },
                  child: Text('Continue'),
                )),
          )
        ],
      ),
    );
  }
}
