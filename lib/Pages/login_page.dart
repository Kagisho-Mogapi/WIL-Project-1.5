import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/helper_user.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/app_progress_indicator.dart';
import 'package:cut_wil_2021/widgets/open_text_field.dart';
import 'package:cut_wil_2021/widgets/regexes.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

// this page will allow a user to login proving their email and password

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final profileFormKey = GlobalKey<FormState>();
  // To capture input
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool? rememberMe = false;
  bool isValidEmail = true;
  bool isValidPass = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, RouteManager.welcome);
            },
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                  top: 50.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height - 120.0,
                    width: MediaQuery.of(context).size.width,
                  )),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: profileFormKey,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/login.jpg',
                            alignment: Alignment.center,
                          ),
                          Focus(
                            onFocusChange: (value) async {
                              if (!value) {
                                setState(() {
                                  if (emailController.text.trim().isEmpty) {
                                    isValidEmail = false;
                                  } else {
                                    isValidEmail = myInputValidation(
                                        emailController.text.trim(),
                                        MyRegexes.email);
                                    if (isValidEmail) {
                                      context
                                          .read<UserService>()
                                          .checkIfUserExists(
                                              emailController.text.trim());
                                    }
                                  }
                                });
                              }
                            },
                            child: OpenTextField(
                              hint: 'Email',
                              regExp: MyRegexes.email,
                              controller: emailController,
                              isPass: false,
                              errorMsg: 'Not Correct Email Format',
                              isValidInput: isValidEmail,
                            ),
                          ),
                          SizedBox(height: 5),
                          Focus(
                            onFocusChange: (value) async {
                              if (!value) {
                                setState(() {
                                  if (passController.text.trim().isEmpty) {
                                    isValidPass = true;
                                  } else {
                                    isValidPass = myInputValidation(
                                        passController.text.trim(),
                                        MyRegexes.password);
                                  }
                                });
                              }
                            },
                            child: OpenTextField(
                              hint: 'Password',
                              regExp: 'Password',
                              controller: passController,
                              isPass: true,
                              errorMsg:
                                  'Minimum eight characters, at least one letter, one number and one special character',
                              isValidInput: isValidPass,
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: buttonStyle(),
                            child: Text('Login'),
                            onPressed: () {
                              loginUserInUI(context,
                                  email: emailController.text,
                                  password: passController.text);
                            },
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: buttonStyle(),
                            child: Text('Reset Password'),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManager.resetPassword);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Checking on {showUserProgress} and {userProgressText}
              Selector<UserService, Tuple2>(
                  selector: (context, value) =>
                      Tuple2(value.showUserProgress, value.userProgressText),
                  builder: (context, value, child) {
                    return value.item1
                        ? AppProgressIndicator(text: '${value.item2}')
                        : Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

ButtonStyle buttonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.orange),
    fixedSize: MaterialStateProperty.all(Size.fromWidth(220)),
  );
}

bool myInputValidation(String input, String regexe) {
  bool isValid = false;

  if (!RegExp(regexe).hasMatch(input)) {
    isValid = false;
  } else {
    isValid = true;
  }

  return isValid;
}
