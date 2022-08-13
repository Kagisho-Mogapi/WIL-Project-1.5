import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Functions/refresh_user_details.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/helper_ticket.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/app_progress_indicator.dart';
import 'package:cut_wil_2021/widgets/ticket_card.dart';
import 'package:provider/provider.dart' as provider;

// This page will allow a user to view tickets they have bought

class ViewMyBoughtTicket extends StatefulWidget {
  const ViewMyBoughtTicket({Key? key}) : super(key: key);

  @override
  _ViewMyBoughtTicketState createState() => _ViewMyBoughtTicketState();
}

class _ViewMyBoughtTicketState extends State<ViewMyBoughtTicket> {
  late TextEditingController ticketController;
  double differance = 0;

  @override
  void initState() {
    super.initState();
    ticketController = TextEditingController();
  }

  @override
  void dispose() {
    ticketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.replay_outlined,
                  color: Colors.orange[700],
                ),
                tooltip: 'Refresh',
                onPressed: () {
                  context.read<TicketService>().getTickets(
                      context.read<UserService>().currentUser!.email);
                }),
            SizedBox(width: 10),
          ],
          elevation: 0,
          backgroundColor: Colors.grey[200],
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.orange[700],
              size: 28,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteManager.newHome);
            },
          )),
      backgroundColor: Colors.grey[200],
      body: Stack(children: [
        SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Background2.jpg'),
                  ),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50)),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 160,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '  Purchase',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '  History List',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Purchases',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.orange[400],
                thickness: 2,
                endIndent: 10,
                indent: 10,
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
                                          child: Text(
                                            'Repeat',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                                color: Colors.teal[400]),
                                          ),
                                          onPressed: () {
                                            double currentBalance =
                                                double.parse(context
                                                    .read<UserService>()
                                                    .currentUser!
                                                    .getProperty('credits'));
                                            if (currentBalance <
                                                double.parse(value
                                                    .tickets[index].price)) {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    content: Text(
                                                        'Current balance is low, balance is R$currentBalance'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text(
                                                          'Topup',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 19,
                                                              color: Colors
                                                                  .teal[400]),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteManager
                                                                  .balanceDetails);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                          'Close',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 19,
                                                              color: Colors
                                                                  .teal[400]),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              differance = currentBalance -
                                                  double.parse(value
                                                      .tickets[index].price);
                                              // UserService.subtractAmount =
                                              //     );
                                              UserService().subtractBalance(
                                                  context
                                                      .read<UserService>()
                                                      .currentUser!
                                                      .email,
                                                  differance);
                                              UserService.userEmail = context
                                                  .read<UserService>()
                                                  .currentUser!
                                                  .email;
                                              createNewTicketInUI(
                                                context,
                                                ownerController: context
                                                    .read<UserService>()
                                                    .currentUser!
                                                    .email,
                                                typeController: value
                                                    .tickets[index].ticketType,
                                                isUsedController:
                                                    value.tickets[index].isUsed,
                                                priceController:
                                                    value.tickets[index].price,
                                              );
                                              saveAllTicketsInUI(context);
                                              refreshUserDetails(context);
                                            }
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Get QR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                                color: Colors.teal[400]),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 120,
                                                            right: 120,
                                                            top: 340,
                                                            bottom: 340),
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      color: Colors.white,
                                                      child: BarcodeWidget(
                                                        data: "username ='${context.read<UserService>().currentUser!.email}' " +
                                                            "&& created = '${value.tickets[index].created}'",
                                                        barcode:
                                                            Barcode.qrCode(),
                                                        color: Colors.black,
                                                        width: 300,
                                                        height: 300,
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                                color: Colors.teal[400]),
                                          ),
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
