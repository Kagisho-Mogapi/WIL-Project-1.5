import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Functions/user_role.dart';
import 'package:cut_wil_2021/screens/chat_screen.dart';
import 'package:cut_wil_2021/screens/home_screen.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../chatt_connect.dart';

class SelectUserScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SelectUserScreen(),
      );

  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  _SelectUserScreenState createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool _loading = false;
  String userID = '';
  String userFullname = '';

  @override
  void initState() {
    super.initState();

    userFullname =
        context.read<UserService>().currentUser!.getProperty('fName') +
            ' ' +
            context.read<UserService>().currentUser!.getProperty('lName');
    userID = context.read<UserService>().currentUser!.getUserId();

    UserRole.userRole == 'admin' ? adminUserSelected() : notAdmin();
  }

  Future<void> notAdmin() async {
    notAdminUserSelected();
    await Future.delayed(Duration(seconds: 4));
    createChannelToStaff(context);
  }

  Future<void> createChannelToStaff(BuildContext context) async {
    final core = StreamChatCore.of(context);
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        core.currentUser!.id,
        'staff',
      ]
    });
    await channel.watch();

    Navigator.of(context).push(
      ChatScreen.routeWithChannel(channel),
    );
  }

  Future<void> notAdminUserSelected() async {
    setState(() {
      _loading = true;
    });

    try {
      final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(
          id: userID,
          extraData: {
            'name': userFullname,
            'image':
                'https://eu.backendlessappcontent.com/6C057E8A-5743-1687-FF77-06AE75443400/69DB8E9D-314B-4389-8BA8-EB1F69E24EC3/files/images/person+2.jpg'
          },
        ),
        client.devToken(userID).rawValue,
      );
    } on Exception catch (e, st) {
      logger.e('Could not connect user', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> adminUserSelected() async {
    setState(() {
      _loading = true;
    });

    try {
      final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(
          id: 'staff',
          extraData: {
            'name': 'Interstate Staff',
            'image':
                'https://eu.backendlessappcontent.com/6C057E8A-5743-1687-FF77-06AE75443400/69DB8E9D-314B-4389-8BA8-EB1F69E24EC3/files/images/interstate+logo+2.png',
          },
        ),
        client.devToken('staff').rawValue,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on Exception catch (e, st) {
      logger.e('Could not connect user', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_loading) ? const CircularProgressIndicator() : Container(),
      ),
    );
  }
}
