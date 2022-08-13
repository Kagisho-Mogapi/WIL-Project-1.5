import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/models/ticket.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart';

// Function for getting the latest tickets
void refreshTicketsInUI(BuildContext context) async {
  // "getTickets" will be called to get the latest tickets of a user
  String result = await context
      .read<TicketService>()
      .getTickets(context.read<UserService>().currentUser!.email);

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data Succefully Loaded!!!');
  }
}

// Function for creating a new Ticket
void createNewTicketInUI(
  BuildContext context, {
  required String typeController,
  required String ownerController,
  required String isUsedController,
  required String priceController,
}) async {
  Ticket ticket = Ticket(
    ticketOwner: ownerController,
    ticketType: typeController,
    isUsed: isUsedController,
    price: priceController,
    created: DateTime.now(),
  );

  //The newly created Ticket is sent to Ticket Service to
  //be saved on the database
  context.read<TicketService>().createTicket(ticket);
  Navigator.pop(context);
}

// Function for creating a new Ticket for another user
void createNewOtherTicketInUI(
  BuildContext context, {
  required String typeController,
  required String ownerController,
  required String isUsedController,
  required String priceController,
}) async {
  Ticket ticket = Ticket(
      ticketOwner: ownerController,
      ticketType: typeController,
      isUsed: isUsedController,
      price: priceController,
      created: DateTime.now());

  //The newly created Ticket of another user is sent to Ticket Service to
  //be saved on the database
  context.read<TicketService>().createOtherTicket(ticket);
  Navigator.pop(context);
}

// Function for saving tickets that would be displayed on the UI
void saveAllTicketsInUI(BuildContext context) async {
  String result = await context
      .read<TicketService>()
      .saveTicketEntry(context.read<UserService>().currentUser!.email, true);

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Ticket Bought!!!');
  }
}

// Function for saving to another user's tickets list
void saveAllOtherTicketsInUI(BuildContext context, String otherUser) async {
  String result =
      await context.read<TicketService>().saveOtherTicketEntry(otherUser, true);

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Ticket Bought!!!');
  }
}
