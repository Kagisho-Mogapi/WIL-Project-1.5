import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Functions/role_assign.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/services/schedule_service.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart';

// Function for registering a new User
void createNewUserInUI(
  BuildContext context, {
  required String email,
  required String password,
  required String fName,
  required String lName,
  required String idNumber,
  required String phoneNumber,
  required String city,
}) async {
  // to remove focus from field
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty ||
      fName.isEmpty ||
      lName.isEmpty ||
      idNumber.isEmpty ||
      phoneNumber.isEmpty ||
      city.isEmpty ||
      password.isEmpty) {
    showSnackBar(context, 'Please Enter All Fields');
  }
  // Set User Details
  else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({
        'fName': fName.trim(),
        'lName': lName.trim(),
        'idNumber': idNumber.trim(),
        'phoneNumber': phoneNumber.trim(),
        'city': city.trim(),
      });
    //Custom columns here

    //The newly created BackendlessUser is sent to User Service to
    //be saved on the database
    String result = await context.read<UserService>().createUser(user);

    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'Account Created!!!');
      Navigator.of(context).pushNamed(RouteManager.login);
    }
  }
}

// Function for logging in a user with provided info from the UI
void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  // For closing the keyboard
  FocusManager.instance.primaryFocus?.unfocus();

  // Check for empty fields
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please Enter All Fields');
  }
  // if no empty fields were found
  else {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());
    // if anything wrong it shows snack bar error message
    if (result != 'OK') {
      showSnackBar(context, result);
    }
    // if everything went OK with the login process
    else {
      RoleAssign.roleAssign(context);
      context.read<ScheduleService>().getSchedules();
      context.read<AnnouncementService>().getAnnouncements('');
      context.read<TicketService>().getTickets(email);

      Navigator.of(context).popAndPushNamed(RouteManager.newHome);
    }
  }
}

// Function for logging out a user thats currently logged in
void logoutUserInUI(BuildContext context) async {
  // the 'logout' function is called to logout the current user
  String result = await context.read<UserService>().logoutUser();
  if (result == 'OK') {
    context.read<UserService>().setCurrentUserNull();
    Navigator.pushNamed(context, RouteManager.login);
  } else {
    showSnackBar(context, result);
  }
}

// Function for reseting a users password
void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context, 'Please Enter Email First');
  } else {
    // the 'resetPassword' function is called to resset a users passwords
    String result =
        await context.read<UserService>().resetPassword(email.trim());

    if (result == 'OK') {
      showSnackBar(context,
          'Successfully Sent Password Reset. Please Check Email for Instructions');
    } else {
      showSnackBar(context, result);
    }
  }
}
