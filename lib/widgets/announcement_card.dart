import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cut_wil_2021/models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    Key? key,
    required this.message,
    required this.deletaAction,
  }) : super(key: key);

  final Announcement message;
  final Function() deletaAction;

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
            message.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
              '${message.created.day}/${message.created.month}/${message.created.year}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[50],
              )),
        ),
      ),
    );
  }
}
