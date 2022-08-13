import 'package:flutter/material.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/helper_ticket.dart';
import 'package:cut_wil_2021/widgets/app_progress_indicator.dart';
import 'package:cut_wil_2021/widgets/ticket_card.dart';
import 'package:provider/provider.dart' as provider;

// This page will allow an admin to view tickets bought by a specific commuter

class ViewUserTickets extends StatefulWidget {
  const ViewUserTickets({Key? key}) : super(key: key);

  @override
  _ViewUserTicketsState createState() => _ViewUserTicketsState();
}

class _ViewUserTicketsState extends State<ViewUserTickets> {
  TextEditingController findController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: Text('View commuter tickets'),
        actions: [
          IconButton(
              icon: Icon(Icons.replay_outlined),
              tooltip: 'Refresh',
              onPressed: () {
                refreshTicketsInUI(context);
              }),
          SizedBox(width: 30),
        ],
      ),
      backgroundColor: Colors.orangeAccent,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height - 82.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
        ),
        Positioned(
            top: 40.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  topRight: Radius.circular(45.0),
                ),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height - 120.0,
              width: MediaQuery.of(context).size.width,
            )),
        SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Interstatelogo.jpg',
                      alignment: Alignment.center,
                      width: 394,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 2,
                endIndent: 10,
                indent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  color: Colors.grey[100],
                  child: ListTile(
                    title: TextField(
                      style: TextStyle(fontSize: 19, color: Colors.teal[400]),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.teal[400]),
                        border: InputBorder.none,
                        hintText: 'Enter Commuter Email',
                      ),
                      controller: findController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    trailing: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.teal[400],
                        ),
                        onPressed: () {
                          context
                              .read<TicketService>()
                              .getTickets(findController.text.trim());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: provider.Consumer<TicketService>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.tickets.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      //title: Text(value.tickets[index].to),
                                      content: Text('Ticket Owner: ${value.tickets[index].ticketOwner}\n' +
                                          'Amount: R${value.tickets[index].price}\n' +
                                          'Ticket Type: ${value.tickets[index].ticketType}\n' +
                                          'Is Used: ${value.tickets[index].isUsed}\n'),
                                      actions: [
                                        TextButton(
                                          child: Text('Close'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: MyTicketCard(
                                message: value.tickets[index],
                                deletaAction: () async {
                                  context
                                      .read<TicketService>()
                                      .deleteTicket(value.tickets[index]);
                                },
                              ),
                            );
                          },
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
        provider.Selector<TicketService, bool>(
          selector: (context, value) => value.busyRetrieving,
          builder: (context, value, child) {
            return value
                ? AppProgressIndicator(
                    text: 'Retrieving data from the database... Please wait...')
                : Container();
          },
        )
      ]),
    );
  }
}

TextStyle myTextStyle() {
  return TextStyle(fontSize: 15, color: Colors.white);
}
