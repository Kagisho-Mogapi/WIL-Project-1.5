import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_wil_2021/widgets/regexes.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Functions/role_assign.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/services/schedule_service.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:cut_wil_2021/keys/keys.dart';

// A splash screen to load and configure the app to Backendless

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  static const String SERVER_URL = Keys.SERVER_URL;
  static const String APPLICATION_ID = Keys.APPLICATION_ID;
  static const String ANDROID_API_KEY = Keys.ANDROID_API_KEY;
  static const String IOS_API_KEY = Keys.IOS_API_KEY;
  static const String JS_API_KEY = Keys.JS_API_KEY;

  @override
  void initState() {
    super.initState();
    init();
    loadTimer();
  }

  void loadTimer() async {
    await Future.delayed(Duration(seconds: 2));
    String result = await context.read<UserService>().checkIfUserLoggedIn();

    await Future.delayed(Duration(seconds: 2));

    if (result == 'OK') {
      RoleAssign.roleAssign(context);
      Navigator.popAndPushNamed(context, RouteManager.newHome);
      context.read<AnnouncementService>().getAnnouncements('');
      context.read<ScheduleService>().getSchedules();

      context
          .read<TicketService>()
          .getTickets(context.read<UserService>().currentUser!.email);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.welcome);
    }
  }

  void init() async {
    await Backendless.setUrl(SERVER_URL);
    await Backendless.initApp(
      applicationId: APPLICATION_ID,
      androidApiKey: ANDROID_API_KEY,
      jsApiKey: JS_API_KEY,
      iosApiKey: IOS_API_KEY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue,
                  Colors.blue.shade900,
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timelapse_outlined,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Loading...please wait...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: LinearProgressIndicator(
                  minHeight: 7,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
