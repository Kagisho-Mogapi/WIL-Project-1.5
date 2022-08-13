import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cut_wil_2021/models/schedule.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
    required this.message,
    required this.deletaAction,
    //required this.messageToggleAction,
  }) : super(key: key);

  final Schedule message;
  final Function() deletaAction;
  //final Function(bool? value) messageToggleAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.grey,
            icon: Icons.delete,
            onTap: deletaAction,
          )
        ],
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          tileColor: Colors.teal[400],
          title: Text(
            'From: ${message.from}, To: ${message.to}, Time: ${message.hour}:${message.minute}, \n' +
                'Day of the Week: ${message.dayOfWeek}, Bus Code: ${message.busCode},',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          /*subtitle: Text(
              '${message.created.day}/${message.created.month}/${message.created.year}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[200],
              )),*/
        ),
      ),
    );
  }
}
