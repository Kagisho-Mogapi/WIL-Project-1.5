import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:provider/provider.dart';

// This page will allow show user their total balance after a successful top-up

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    exitPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Successful.png',
                      alignment: Alignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: 44,
                        // ),
                        Text(
                          'Payment Successful',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total amount : R${UserService.topUpAmount}',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your account has been loaded',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Thank You',
                          style: TextStyle(fontSize: 26, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> exitPage(BuildContext context) async {
  String result = await context.read<UserService>().checkIfUserLoggedIn();
  await Future.delayed(Duration(seconds: 5));
  print('Load results: $result');
  Navigator.pushNamed(context, RouteManager.newHome);
}
