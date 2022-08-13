import 'package:flutter/material.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/services/schedule_service.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:provider/provider.dart';

import 'Routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // List of providers
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => AnnouncementService()),
        ChangeNotifierProvider(create: (context) => ScheduleService()),
        ChangeNotifierProvider(create: (context) => TicketService()),
      ],
      child: MaterialApp(
        initialRoute: RouteManager.loading,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
