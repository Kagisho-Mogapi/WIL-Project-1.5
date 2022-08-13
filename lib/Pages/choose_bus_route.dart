// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

class ChooseBusRoute extends StatefulWidget {
  const ChooseBusRoute({Key? key}) : super(key: key);

  @override
  _ChooseBusRouteState createState() => _ChooseBusRouteState();
}

// A page that will allow a user choose a route they want to view it's schedule

class _ChooseBusRouteState extends State<ChooseBusRoute> {
  final items = ['Route 1', 'Route 2', 'Route 3'];
  String? value;
  String radioButtonItem = 'Mondays to Fridays';
  String areaItem = 'Botshabelo';
  int id = 1;
  int area = 1;

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Interstatelogo.jpg'),
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Timetables',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Mondays to Fridays';
                                id = 1;
                              });
                            },
                          ),
                          Text('Mondays to Fridays'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Saturdays';
                                id = 2;
                              });
                            },
                          ),
                          Text('Saturdays'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 3,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Sundays';
                                id = 3;
                              });
                            },
                          ),
                          Text('Sundays'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Area',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: area,
                            onChanged: (val) {
                              setState(() {
                                areaItem = 'Botshabelo';
                                area = 1;
                              });
                            },
                          ),
                          Text('Botshabelo'),
                          Radio(
                            value: 2,
                            groupValue: area,
                            onChanged: (val) {
                              setState(() {
                                areaItem = 'Mangaung';
                                area = 2;
                              });
                            },
                          ),
                          Text('Mangaung'),
                          Radio(
                            value: 3,
                            groupValue: area,
                            onChanged: (val) {
                              setState(() {
                                areaItem = 'Suburbs';
                                area = 3;
                              });
                            },
                          ),
                          Text('Suburbs'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 4,
                            groupValue: area,
                            onChanged: (val) {
                              setState(() {
                                areaItem = 'Thaba Nchu';
                                area = 4;
                              });
                            },
                          ),
                          Text('Thaba Nchu'),
                          Radio(
                            value: 5,
                            groupValue: area,
                            onChanged: (val) {
                              setState(() {
                                areaItem = 'Other';
                                area = 5;
                              });
                            },
                          ),
                          Text('Other'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Route',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: DropdownButton<String>(
                                items: items.map(buildMenuItem).toList(),
                                onChanged: (value) =>
                                    setState(() => this.value = value),
                                hint: Text('Choose Route'),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
