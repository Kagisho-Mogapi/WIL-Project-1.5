import 'package:cut_wil_2021/Functions/user_role.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/user_service.dart';

// to assign a role of user depending on the domain of the email
class RoleAssign {
  static void roleAssign(BuildContext context) {
    if (context
        .read<UserService>()
        .currentUser!
        .email
        .contains('@interstate.admin')) {
      UserRole.userRole = 'admin';
    } else if (context
        .read<UserService>()
        .currentUser!
        .email
        .contains('@interstate.driver')) {
      UserRole.userRole = 'driver';
    } else {
      UserRole.userRole = 'commuter';
    }
    print(UserRole.userRole);
  }
}
