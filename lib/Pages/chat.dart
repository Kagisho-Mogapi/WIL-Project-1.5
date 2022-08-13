import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/Themes/theme.dart';
import 'package:cut_wil_2021/chatt_connect.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/screens/select_user_screen.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

// A page that will initialize the chat feature

class Chat extends StatelessWidget {
  Chat({
    Key? key,
    //required this.client,
  }) : super(key: key);

  final client = StreamChatClient(streamKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context, RouteManager.newHome);
          },
        ),
        backgroundColor: Colors.black54,
      ),
      body: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        title: 'Interstate Bus Line Services',
        builder: (context, child) {
          return StreamChatCore(
            client: client,
            child: ChannelsBloc(
              child: UsersBloc(
                child: child!,
              ),
            ),
          );
        },
        home: const SelectUserScreen(),
      ),
    );
  }
}
