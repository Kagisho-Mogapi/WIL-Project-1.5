import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Pages/buy_ticket.dart';
import 'package:cut_wil_2021/Pages/chat.dart';
import 'package:cut_wil_2021/Pages/create_schedule.dart';
import 'package:cut_wil_2021/Pages/create_announcement.dart';
import 'package:cut_wil_2021/Pages/edit_profile_page.dart';
import 'package:cut_wil_2021/Pages/home.dart';
import 'package:cut_wil_2021/Pages/loading.dart';
import 'package:cut_wil_2021/Pages/login_page.dart';
import 'package:cut_wil_2021/Pages/payment_details.dart';
import 'package:cut_wil_2021/Pages/profile_page.dart';
import 'package:cut_wil_2021/Pages/qrPage.dart';
import 'package:cut_wil_2021/Pages/successPage.dart';
import 'package:cut_wil_2021/Pages/topup_balance.dart';
import 'package:cut_wil_2021/Pages/reset_password.dart';
import 'package:cut_wil_2021/Pages/signUp_page.dart';
import 'package:cut_wil_2021/Pages/view_announcement.dart';
import 'package:cut_wil_2021/Pages/view_bought_tickets.dart';
import 'package:cut_wil_2021/Pages/view_bus_schedule.dart';
import 'package:cut_wil_2021/Pages/view_user_tickets.dart';
import 'package:cut_wil_2021/Pages/welcome_page.dart';
import 'package:cut_wil_2021/widgets/area_and_day_choice.dart';

// A class to manage page routes
class RouteManager {
  static const String newHome = '/new home';

  static const String loading = '/loading';
  static const String welcome = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String resetPassword = '/login/reset password';
  static const String home = '/login/home';
  static const String chooseBusRoute = '/login/chooseBusRoute';
  static const String balanceDetails = '/login/home/balanceDetails';
  static const String chatting = '/login/home/chatting';
  static const String userTickets = '/login/userTickets';
  static const String messages = '/login/home/messages';
  static const String buy = '/login/home/Buy';
  static const String purchaseDetails = '/login/home/Buy/PuchaseDetails';
  static const String successfulTopup =
      '/login/home/Buy/PuchaseDetails/successfulTopup';
  static const String boughtHistory =
      '/login/home/Buy/PuchaseDetails/boughtHistory';
  static const String topupBalance = '/login/home/topupBalance';
  static const String history = '/login/home/history';
  static const String schedule = '/login/home/schedule';
  static const String writeSchedule = '/login/home/schedule/writeSchedule';
  static const String balance = '/login/home/balance';
  static const String announcements = '/login/home/announcements';
  static const String writeAnnouncements =
      '/login/home/announcements/writeAnnouncements';
  static const String profile = '/login/home/profile';
  static const String scanQR = '/login/home/scanQR';
  static const String editProfile = '/login/home/profile/edit profile';
  ////////////////
  static const String paymentDetails = '/login/home/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loading:
        return MaterialPageRoute(builder: (context) => const Loading());

      case welcome:
        return MaterialPageRoute(builder: (context) => WelcomePage());

      case register:
        return MaterialPageRoute(builder: (context) => const SignUpPage());

      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case resetPassword:
        return MaterialPageRoute(builder: (context) => const ResetPassword());

      case buy:
        return MaterialPageRoute(builder: (context) => const BuyForUser());

      case boughtHistory:
        return MaterialPageRoute(
            builder: (context) => const ViewMyBoughtTicket());

      case userTickets:
        return MaterialPageRoute(builder: (context) => const ViewUserTickets());

      case chooseBusRoute:
        return MaterialPageRoute(
            builder: (context) => const AreaAndDayChoice());

      case messages:
        return MaterialPageRoute(builder: (context) => Chat());

      case newHome:
        return MaterialPageRoute(builder: (context) => const Home());

      case balanceDetails:
        return MaterialPageRoute(builder: (context) => const TopupBalance());

      case balanceDetails:
        return MaterialPageRoute(builder: (context) => const TopupBalance());

      case successfulTopup:
        return MaterialPageRoute(builder: (context) => const SuccessPage());

      case schedule:
        return MaterialPageRoute(builder: (context) => const ViewBusSchedule());

      case writeSchedule:
        return MaterialPageRoute(builder: (context) => const CreateSchedule());

      case scanQR:
        return MaterialPageRoute(builder: (context) => const QrPage());

      case announcements:
        return MaterialPageRoute(
            builder: (context) => const ViewAnnouncement());

      case writeAnnouncements:
        return MaterialPageRoute(
            builder: (context) => const CreateAnnouncement());

      case profile:
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      case editProfile:
        return MaterialPageRoute(builder: (context) => const EditProfile());

      // case messages:
      //   return MaterialPageRoute(builder: (context) => MessagePage());

      case paymentDetails:
        return MaterialPageRoute(builder: (context) => const PaymentDetails());

      default:
        throw const FormatException('Route not found, check route again!!');
    }
  }
}
