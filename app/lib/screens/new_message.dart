import 'package:flutter/material.dart';
import 'package:zero/widgets/conversation_list_item.dart';
import 'package:zero/models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:zero/constants.dart';

class NewMessageScreen extends StatefulWidget {
  NewMessageScreen({Key? key}) : super(key: key);

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _searchString;

  void _handleChanged(String text) {
    print('text: "$text"');
    setState(() {
      _searchString = text;
    });

    _focusNode.requestFocus();
  }

  Future<List<User>?> findUsers(String? searchString) async {
    if (searchString == null || searchString == '') {
      return null;
    }

    return Amplify.DataStore.query(User.classType,
        where: User.USERNAME.contains(searchString));
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
                      const Text("New message",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                onChanged: _handleChanged,
                decoration: InputDecoration(
                    hintText: "Find new people by they\'re @username",
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
          FutureBuilder<List<User>?>(
              future: findUsers(_searchString),
              builder: (context, future) {
                print(future.data);
                if (!future.hasData || future.data!.isEmpty) {
                  return Center(
                    heightFactor: 2,
                    child: Icon(
                      Icons.search,
                      size: 250,
                      color: Colors.grey.shade200,
                    ),
                  );
                } else {
                  final users = future.data;
                  return ListView.builder(
                    itemCount: users!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ConversationListItem(
                        username: users[index].username,
                        lastMessage: users[index]
                                .Messages?[users[index].Messages!.length - 1]
                                .content ??
                            'Start a new conversation with ${users[index].username}',
                        profilePictureUrl: users[index].profilePictureUrl ??
                            G_DEFAULT_PROFILE_PICTURE,
                        // createdOn: users[index].createdOn,
                        createdOn: 'Now',
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                      );
                    },
                  );
                }
              }),
        ],
      ),
    ));
  }
}
