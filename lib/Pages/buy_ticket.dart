import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Functions/refresh_user_details.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/helper_ticket.dart';
import 'package:cut_wil_2021/services/ticket_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/regexes.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart';

// A page that will a user buy a ticket for them selves or someone

class BuyForUser extends StatefulWidget {
  const BuyForUser({Key? key}) : super(key: key);

  @override
  _BuyForUserState createState() => _BuyForUserState();
}

class _BuyForUserState extends State<BuyForUser> {
  bool buyForMe = true;
  TextEditingController typeController = TextEditingController();
  TextEditingController isUsedController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController recipientController = TextEditingController();

  @override
  void dispose() {
    typeController.dispose();
    isUsedController.dispose();
    priceController.dispose();

    super.dispose();
  }

  final List<String> receipients = [
    'Me',
    'Someone',
  ];

  final List<String> ticketTypeOption = [
    'QR Code',
    'Tag',
  ];

  final List<String> locations = [
    'Thaba Nchu',
    'Botshabelo',
    'Bloemfontein',
    'Botshabelo',
  ];

  String? value;
  String? recipient;
  double differance = 0;
  bool isAmountValid = true;

  DropdownMenuItem<String> buildMenuItem(String admin) => DropdownMenuItem(
      value: admin,
      child: Text(
        admin,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ));

  @override
  Widget build(BuildContext context) {
    ////
    ///
    ///
    ///

    isUsedController.text = 'False';

    ///
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        title: Text('Purchase Details'),
      ),
      backgroundColor: Colors.orangeAccent,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 82.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
          ),
          Positioned(
              top: 50.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Background1.jpg'),
                    fit: BoxFit.cover,
                  ),
                  // color: Colors.orangeAccent,
                ),
                height: MediaQuery.of(context).size.height - 120.0,
                width: MediaQuery.of(context).size.width,
              )),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 44,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.teal.shade400,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton(
                        onChanged: (value) => setState(() {
                          this.value = value as String?;
                          typeController.text = this.value!;
                        }),
                        underline: Container(),
                        style: TextStyle(color: Colors.teal[400], fontSize: 17),
                        value: value,
                        items: ticketTypeOption.map(buildMenuItem).toList(),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.teal[400]),
                        iconSize: 20,
                        hint: Text(
                          'Choose ticket type',
                          style: TextStyle(color: Colors.teal[400]),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 300,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.teal.shade400,
                          width: 2,
                        ),
                      ),
                      child: DropdownButton(
                        style: TextStyle(color: Colors.teal[400], fontSize: 17),
                        underline: Container(),
                        onChanged: (value) => setState(() {
                          this.recipient = value as String?;
                          if (value == 'Someone') {
                            buyForMe = false;
                          } else {
                            buyForMe = true;
                          }
                        }),
                        value: recipient,
                        items: receipients.map(buildMenuItem).toList(),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.teal[400]),
                        iconSize: 20,
                        hint: Text('Choose recipient',
                            style: TextStyle(color: Colors.teal[400])),
                      ),
                    ),
                    SizedBox(height: 15),
                    !buyForMe
                        ? Container(
                            width: 300,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.teal.shade400,
                                width: 2,
                              ),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 19, color: Colors.teal[400]),
                              controller: recipientController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Recipient',
                                hintStyle: TextStyle(color: Colors.teal[400]),
                              ),
                            ),
                          )
                        : Container(),

                    // reciver(buyForMe),
                    SizedBox(height: 15),
                    Focus(
                      onFocusChange: (value) {
                        if (priceController.text.trim().isEmpty) {
                          isAmountValid = true;
                        } else {
                          isAmountValid = myInputValidation(
                              priceController.text.trim(), MyRegexes.number);
                        }
                      },
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.teal.shade400,
                            width: 2,
                          ),
                        ),
                        child: TextField(
                          style:
                              TextStyle(fontSize: 19, color: Colors.teal[400]),
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: isAmountValid ? null : 'Number only!!!',
                            hintText: 'Enter Amount',
                            hintStyle: TextStyle(color: Colors.teal[400]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[400],
                          fixedSize: Size(270, 60),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          double currentBalance = double.parse(context
                              .read<UserService>()
                              .currentUser!
                              .getProperty('credits'));
                          if (priceController.text.trim().isEmpty ||
                              typeController.text.trim().isEmpty) {
                            showSnackBar(
                                context, 'Please Enter All Fields First');
                          } else {
                            if (!isAmountValid) {
                              showSnackBar(
                                  context, 'Amount should only be numbers');
                            } else if (currentBalance <
                                double.parse(priceController.text.trim())) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    //title: Text(value.tickets[index].to),
                                    content: Text(
                                        'Current balance is low, balance is R$currentBalance'),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Topup',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 19,
                                              color: Colors.teal[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              RouteManager.balanceDetails);
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
                            } else {
                              differance = currentBalance -
                                  double.parse(priceController.text.trim());
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

                              if (!buyForMe) {
                                context
                                    .read<TicketService>()
                                    .getOtherTickets(recipientController.text);

                                await Future.delayed(Duration(seconds: 2));
                                createNewOtherTicketInUI(
                                  context,
                                  ownerController: context
                                      .read<UserService>()
                                      .currentUser!
                                      .email,
                                  typeController: typeController.text.trim(),
                                  isUsedController:
                                      isUsedController.text.trim(),
                                  priceController: priceController.text.trim(),
                                );
                                saveAllOtherTicketsInUI(
                                    context, recipientController.text);
                              } else {
                                createNewTicketInUI(
                                  context,
                                  ownerController: context
                                      .read<UserService>()
                                      .currentUser!
                                      .email,
                                  typeController: typeController.text.trim(),
                                  isUsedController:
                                      isUsedController.text.trim(),
                                  priceController: priceController.text.trim(),
                                );
                                saveAllTicketsInUI(context);
                              }
                              refreshUserDetails(context);
                            }
                          }
                        },
                        child: Text(
                          'Pay',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

bool myInputValidation(String input, String regexe) {
  bool isValid = false;

  if (!RegExp(regexe).hasMatch(input)) {
    isValid = false;
  } else {
    isValid = true;
  }

  return isValid;
}

Widget reciver(bool forMe) {
  Widget widget = Container();

  if (!forMe) {
    widget = Container(
      width: 300,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Recipient',
        ),
      ),
    );
  }

  return widget;
}
