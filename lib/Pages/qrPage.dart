import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

// This page will allow developers to test QR Code outputs

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final controller = TextEditingController();
  String data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Q R  C o d e'),
      ),
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Background1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Opacity(
            opacity: 0.85,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red, Colors.blue]),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 370,
                    height: 370,
                    color: Colors.white,
                    child: BarcodeWidget(
                      data: controller.text,
                      barcode: Barcode.qrCode(),
                      color: Colors.black,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Insert Cell number to generate code',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.done, size: 30),
                          onPressed: () => setState(() {}),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
