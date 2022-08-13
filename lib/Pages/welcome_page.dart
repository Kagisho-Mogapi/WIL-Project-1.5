import 'dart:ui';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/widgets/material_btn_a.dart';

// This is the page first page of the app that allows a user to either
// register or login

class WelcomePage extends StatelessWidget {
  void initState() {
    init();
  }

  void init() async {
    await Backendless.setUrl('https://eu-api.backendless.com');

    await Backendless.initApp(
        applicationId: '6C057E8A-5743-1687-FF77-06AE75443400',
        iosApiKey: '6A6097DF-84AC-442F-AEA9-FADDCE16F1CB',
        androidApiKey: '5771E324-6F0D-4CF2-A813-D9339D3223FD',
        jsApiKey: 'CBB3571F-FB60-4DDE-95B3-21615345B79B');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Background1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/Interstatelogo.jpg',
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Interstate Bus Line',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Making life easier for our commuters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialBtnA(
                        btnName: 'Sign Up', location: RouteManager.register),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialBtnA(
                        btnName: 'Sign In', location: RouteManager.login),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
