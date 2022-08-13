import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart';

// This page will allow a user to view and enter their top-up amount

class TopupBalance extends StatefulWidget {
  const TopupBalance({Key? key}) : super(key: key);

  @override
  _TopupBalanceState createState() => _TopupBalanceState();
}

class _TopupBalanceState extends State<TopupBalance> {
  TextEditingController amountController = TextEditingController();
  int currentBalance = 0;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/PurchaseDetail.png',
                      alignment: Alignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 44,
                        ),
                        Text(
                          'Topup Balance',
                          style:
                              TextStyle(fontSize: 22, color: Colors.teal[400]),
                        ),
                        Text(
                          'R${context.read<UserService>().currentUser!.getProperty('credits')}',
                          style:
                              TextStyle(fontSize: 22, color: Colors.teal[400]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
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
                      style: TextStyle(fontSize: 19, color: Colors.teal[400]),
                      controller: amountController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.teal[400]),
                        border: InputBorder.none,
                        hintText: 'Enter Amount',
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
                      onPressed: () {
                        if (amountController.text.trim().isNotEmpty) {
                          double amountInt =
                              double.parse(amountController.text.trim());
                          double creditsInt = double.parse(context
                              .read<UserService>()
                              .currentUser!
                              .getProperty('credits'));

                          UserService.topUpAmount = amountInt + creditsInt;

                          Navigator.pushNamed(
                              context, RouteManager.paymentDetails);
                        } else {
                          showSnackBar(context, 'Enter All Fields');
                        }
                      },
                      child: Text(
                        'Topup',
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
          )
        ],
      ),
    );
  }
}
