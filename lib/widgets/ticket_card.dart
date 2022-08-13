import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cut_wil_2021/models/ticket.dart';
import 'package:cut_wil_2021/models/user.dart';

class MyTicketCard extends StatelessWidget {
  const MyTicketCard({
    Key? key,
    required this.message,
    required this.deletaAction,
    //required this.messageToggleAction,
  }) : super(key: key);

  final Ticket message;
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
            'Ticket Owner: ${message.ticketOwner} ' +
                ', Ticket Type: ${message.ticketType}, Ticket Price: R${message.price}, Is Used: ${message.isUsed}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class OtherUserTickets extends StatelessWidget {
  const OtherUserTickets({
    Key? key,
    required this.user,
    required this.deletaAction,
    //required this.messageToggleAction,
  }) : super(key: key);

  final User user;
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
          tileColor: Colors.lightBlueAccent,
          title: Text(
            'phoneNumber: ${user.email}',
            style: TextStyle(
              color: Colors.orange[900],
            ),
          ),
        ),
      ),
    );
  }
}
