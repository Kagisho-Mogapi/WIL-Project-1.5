import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserService with ChangeNotifier {
  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;
  static String userEmail = '';
  static double topUpAmount = 0;
  static double subtractAmount = 0;

  String users = '';
  String result = 'OK';

  bool _userExists = false;
  bool get userExists => _userExists;

  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => _userProgressText;

// Function for setting current user to null
  void setCurrentUserNull() {
    _currentUser = null;
  }

// Function for checking if user alread exists
  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

// Function for reseting a user's passwords
  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Reseting the password... Please Wait...';
    notifyListeners();

    // the app will call Backendless services to help with reseting a password
    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

// Function to logout a user
  Future<String> logoutUser() async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Signing Out... Please Wait...';
    notifyListeners();

    // the app will use Backendless services to help with logging out the
    //current user
    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });

    _showUserProgress = false;
    notifyListeners();
    return result;
  }

// Function to check if a user has already registered
  void checkIfUserExists(String username) async {
    // this query will look for matching emails on the database
    DataQueryBuilder? queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    // the app will use Backendless services to on the Users tables for
    // matching emails
    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      // Validating when focus is lost that if user does exits
      if (value == null || value.length == 0) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

// Function to login a user with the provided details
  Future<String> loginUser(String username, String password) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Logging In.... Please Wait';
    notifyListeners();

    // Logging in a user using Backendless services
    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });

    if (user != null) {
      _currentUser = user;
      userEmail = _currentUser!.email;
    }

    _showUserProgress = false;
    notifyListeners();

    return result;
  }

// Function to check if user is already logged in
  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    // Checks if there was a valid login using Backendless services
    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (validLogin != null && validLogin) {
      // Retrives the current user's Object Id
      String? currentUserObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });
      if (currentUserObjectId != null) {
        // finds the user from {Users} table using {currentUserObjectId} and retrive
        // their Json
        Map<dynamic, dynamic>? mapOfCurentUser = await Backendless.data
            .of('Users')
            .findById(currentUserObjectId)
            .onError((error, stackTrace) {
          result = error.toString();
        });

        if (mapOfCurentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurentUser);
          userEmail = _currentUser!.email;

          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }
    return result;
  }

// Function for updating user profile details
  Future<void> updateProfile(
    BuildContext context,
    String fNameEdit,
    String lNameEdit,
    String phoneNumberEdit,
    String passwordEdit,
  ) async {
    Map<dynamic, dynamic> entity = {}; // map of changes
    int? saveChange = -1;

    // fields a checked is they are empty or not
    if (fNameEdit.isNotEmpty) {
      entity.addAll({'fName': '$fNameEdit'});
    }

    if (lNameEdit.isNotEmpty) {
      entity.addAll({'lName': '$lNameEdit'});
    }

    if (phoneNumberEdit.isNotEmpty) {
      entity.addAll({'phoneNumber': '$phoneNumberEdit'});
    }

    // for updating user password
    if (passwordEdit.isNotEmpty) {
      BackendlessUser? user = context.read<UserService>().currentUser;
      user!.password = passwordEdit;
      Backendless.data
          .of("Users")
          .save(user.toJson())
          .then((response) => print("User password has been changed"));
    }

    // The updates are applied to user
    saveChange = await Backendless.data.of("Users").update(
        "email ='${context.read<UserService>().currentUser!.email}'", entity);

    // print(saveChange);
  }

// Function to top-up user balance
  Future<void> topUpBalance(String username) async {
    // updates user balance on Backendless
    final topUpBalance = await Backendless.data
        .of("Users")
        .update("email ='$username'", {'credits': topUpAmount});
    print('Topup Result: $topUpBalance');
  }

// Function to subtract from user balance
  Future<void> subtractBalance(String username, double diff) async {
    // updates user balance on Backendless
    final topUpBalance = await Backendless.data
        .of("Users")
        .update("email ='$username'", {'credits': diff});
    print('Subtract Result: $topUpBalance');
  }

// Function for creating a new user
  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Creating Account... Please Wait...';
    notifyListeners();

    try {
      // Registers a new user to Backendless using Backendless services
      await Backendless.userService.register(user);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }

    // When account is successfully created
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

// Function for displaying human readable errors
  String getHumanReadableError(String message) {
    if (message.contains('email address must be confirmed first')) {
      return 'Please check your inbox and confirm your email address and try to login again.';
    }
    if (message.contains('User already exists')) {
      return 'This user already exists in our database. Please create a new user.';
    }
    if (message.contains('Invalid login or password')) {
      return 'Please check your username or password. The combination do not match any entry in our database.';
    }
    if (message
        .contains('User account is locked out due to too many failed logins')) {
      return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
    }
    if (message.contains('Unable to find a user with the specified identity')) {
      return 'Your email address does not exist in our database. Please check for spelling mistakes.';
    }
    if (message.contains(
        'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
      return 'It seems as if you do not have an internet connection. Please connect and try again.';
    }
    return message;
  }
}
