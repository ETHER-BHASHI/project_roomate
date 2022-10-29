import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/db/entity/app_user.dart';
import '../../../data/model/chat_with_user.dart';
import '../../../data/provider/user_provider.dart';
import '../../widgets/chats_list.dart';
import '../../widgets/custom_modal_progress_hud.dart';
import '../chat_screen.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  void chatWithUserPressed(ChatWithUser chatWithUser) async {
    AppUser user = await Provider.of<UserProvider>(context, listen: false).user;
    Navigator.pushNamed(context, ChatScreen.id, arguments: {
      "chat_id": chatWithUser.chat.id,
      "user_id": user.id,
      "other_user_id": chatWithUser.user.id
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return FutureBuilder<AppUser>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                  inAsyncCall:
                      userProvider.isLoading,
                  offset: Offset.fromDirection(1.0),
                  key: null,
                  child: (userSnapshot.hasData)
                      ? FutureBuilder<List<ChatWithUser>>(
                          future: userProvider
                              .getChatsWithUser(userSnapshot.data?.id),
                          builder: (context, chatWithUsersSnapshot) {
                            if (chatWithUsersSnapshot.data == null &&
                                chatWithUsersSnapshot.connectionState !=
                                    ConnectionState.done) {
                              return CustomModalProgressHUD(
                                  inAsyncCall: true, key: ,
                                  offset: Offset.fromDirection(1.0),
                                  child: Container());
                            } else {
                              return chatWithUsersSnapshot.data?.length == 0
                                  ? Center(
                                      child: Container(
                                          child: Text('No matches',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4)),
                                    )
                                  : ChatsList(
                                      chatWithUserList:
                                          chatWithUsersSnapshot.data,
                                      onChatWithUserTap: chatWithUserPressed,
                                      myUserId: userSnapshot.data.id,
                                    );
                            }
                          })
                      : Container(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
