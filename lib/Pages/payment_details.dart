import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:provider/provider.dart';

// This page will allow a user to input their banking details for a top-up

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModel(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange[700],
              size: 28,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteManager.balanceDetails);
            },
          )),
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: showBackView,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              cardBgColor: Colors.black,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/images/MasterCard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
              animationDuration: Duration(milliseconds: 100),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Payment Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: onCreditCardModel,
                  themeColor: Colors.blue,
                  textColor: Colors.black,
                  formKey: formKey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Colors.black,
                ),
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: const Text(
                    'Validate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    print('valid!');
                    UserService().topUpBalance(
                        context.read<UserService>().currentUser!.email);

                    Navigator.pushNamed(context, RouteManager.successfulTopup);
                  } else {
                    print('invalid!');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
