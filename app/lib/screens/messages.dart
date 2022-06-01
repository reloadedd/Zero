import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:zero/constants.dart';
import 'package:zero/models/Chat.dart';
import 'package:zero/models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:zero/screens/new_message.dart';
import 'package:zero/widgets/conversation_list_item.dart';

Future<void> createNewUserFirstTime() async {
  final current_user = await Amplify.Auth.getCurrentUser();
  final isAlreadyAdded = await Amplify.DataStore.query(User.classType,
      where: User.USERNAME.eq(current_user.username));

  if (isAlreadyAdded.isNotEmpty) {
    Amplify.DataStore.save(
        new User(username: current_user.username, id: current_user.userId));
  }
}

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
    createNewUserFirstTime();
  }

  Future<List<User>> getChats() async {
    final current_user = await Amplify.Auth.getCurrentUser();
    final chats = await Amplify.DataStore.query(Chat.classType,
        where: Chat.FROM.eq(current_user));

    List<User> chattedWith = <User>[];
    for (var chat in chats) {
      final user = await Amplify.DataStore.query(User.classType,
          where: User.USERNAME.eq(chat.to));

      chattedWith.add(user[0]);
    }

    return chattedWith;
  }

  @override
  Widget build(BuildContext context) {
    // Amplify.DataStore.save(User(username: 'test'));
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Messages"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: "Profile")
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                                  color: Colors.red.withAlpha(30)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          NewMessageScreen())));
                                },
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "New message",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade100))),
                  )),
              FutureBuilder<List<User>>(
                  future: getChats(),
                  builder: (context, future) {
                    if (!future.hasData || future.data!.isEmpty) {
                      return Center(
                          heightFactor: 30,
                          child: Text('Nothing here, just crickets...',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w200)));
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
                                    .Messages?[
                                        users[index].Messages!.length - 1]
                                    .content ??
                                'Start a new conversation with ${users[index].username}',
                            profilePictureUrl: users[index].profilePictureUrl ??
                                G_DEFAULT_PROFILE_PICTURE,
                            createdOn: users[index].createdOn.toString(),
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
