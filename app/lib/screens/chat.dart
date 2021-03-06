import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:zero/constants.dart';
import 'package:zero/crypto/mnemonic.dart';
import 'package:zero/models/Message.dart';
import 'package:animations/animations.dart';
import 'package:zero/helpers.dart';
import 'package:zero/models/ModelProvider.dart';
import 'package:zero/crypto/rsa.dart' as rsa;
import 'package:zero/crypto/salsa.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:zero/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late RSAPublicKey publicKey;
  late RSAPrivateKey privateKey;
  rsa.RSA pki = new rsa.RSA();

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
        where: Chat.SENDERUSERNAME
            .eq(senderUsername)
            .and(Chat.RECEIVERUSERNAME.eq(receiverUsername)));
    print('chats = $chats');
    if (chats.isEmpty) {
      Amplify.DataStore.save(new Chat(
          userID: senderID,
          senderUsername: senderUsername,
          receiverUsername: receiverUsername));
    }
  }

  Future<void> _cryptoSetup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final seedPhase = prefs.getString(G_SEED_PHASE);
    Mnemonic mnemonic = Mnemonic(seedPhase);

    final pair = pki.generateRSAkeyPair(mnemonic);
    publicKey = pair.publicKey;
    privateKey = pair.privateKey;

    final key = encrypt.IV.fromSecureRandom(G_SALSA20_KEY_LENGTH);
    final iv = encrypt.IV.fromSecureRandom(G_SALSA20_IV_LENGTH);
    final encryptedSalsaKey =
        pki.encrypt(publicKey, convertStringToUint8List(key.base64));
    final encryptedSalsaIV =
        pki.encrypt(publicKey, convertStringToUint8List(iv.base64));
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
    final outgoing = await Amplify.DataStore.query(Message.classType,
        where: Message.SENDERID
            .eq(senderID)
            .and(Message.RECEIVERID.eq(receiverID)));
    final incoming = await Amplify.DataStore.query(Message.classType,
        where: Message.SENDERID
            .eq(receiverID)
            .and(Message.RECEIVERID.eq(senderID)));

    outgoing.addAll(incoming);
    // print('Mesages: $outgoing');

    return outgoing;
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
                  onPressed: () => _handleSubmitted(_textController.text),
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
