import 'package:flutter/material.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/services/schedule_service.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:provider/provider.dart';

class MyElevatedBtnA extends StatelessWidget {
  const MyElevatedBtnA({
    Key? key,
    required this.btnName,
    required this.routeName,
    required this.getMeSome,
  }) : super(key: key);

  final String btnName;
  final String routeName;
  final String getMeSome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          child: Text(
            btnName,
            style: TextStyle(fontSize: 15),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(routeName);
          getThose(context, getMeSome);
        },
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.teal[400]),
          fixedSize: MaterialStateProperty.all(Size.fromWidth(220)),
        ),
      ),
    );
  }
}

void getThose(BuildContext context, String getSome) {
  if (getSome == 'tickets') {
    context
        .read<TicketService>()
        .getTickets(context.read<UserService>().currentUser!.email);
  } else if (getSome == 'schedules') {
    context.read<ScheduleService>().getSchedules();
  } else if (getSome == 'annoucements') {
    context.read<AnnouncementService>().getAnnouncements('');
  }
}
