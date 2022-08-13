import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Pages/view_bus_schedule.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/helper_schedule.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';

class AreaAndDayChoice extends StatefulWidget {
  const AreaAndDayChoice({Key? key}) : super(key: key);

  @override
  _AreaAndDayChoiceState createState() => _AreaAndDayChoiceState();
}

class _AreaAndDayChoiceState extends State<AreaAndDayChoice> {
  List<String> botshabeloArea = [
    'A1',
    'A4',
    'N1',
    'C1 ',
    'F3',
    'J3',
  ];
  List<String> mangaungArea = [
    'Limo Mall',
    'Central Park',
    'Mafora',
    'Phase 2',
    'Turflaagte',
    'Bloemside'
  ];
  List<String> suburbsArea = [
    'Bayswater',
    'Brandwag',
    'Vista',
    'Universitas',
    'Bidvest',
    'Fauna'
  ];
  List<String> thabaNchuArea = [
    'Mokwena',
    'Morago',
    'Paradys',
    'Moroto',
    'Sediba',
    'Merino'
  ];
  List<String> fromRoute = [
    'A1',
    'A4',
    'N1',
    'C1 ',
    'F3',
    'J3',
  ];
  List<String> toRoute = [
    'A1',
    'A4',
    'N1',
    'C1 ',
    'F3',
    'J3',
  ];
  String? fromValue;
  String? toValue;
  String radioButtonItem = 'Mondays to Fridays';
  String areaItem = 'Botshabelo';
  int fromID = 1;
  int fromArea = 1;
  int toID = 1;
  int toArea = 1;

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text(
            'Choose route',
            style: TextStyle(color: Colors.orange[700]),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Day of the week',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal[400],
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
                    activeColor: Colors.teal[400],
                    value: 1,
                    groupValue: fromID,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Mondays to Fridays';
                        fromID = 1;
                      });
                    },
                  ),
                  Text(
                    'Mondays to Fridays',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 2,
                    groupValue: fromID,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Saturdays';
                        fromID = 2;
                      });
                    },
                  ),
                  Text(
                    'Saturdays',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 3,
                    groupValue: fromID,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Sundays';
                        fromID = 3;
                      });
                    },
                  ),
                  Text(
                    'Sundays',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 15, thickness: 5, color: Colors.orange[400]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'From Area',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal[400],
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
                    activeColor: Colors.teal[400],
                    value: 1,
                    groupValue: fromArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Botshabelo';
                        fromArea = 1;
                        fromRoute = botshabeloArea;
                        this.fromValue = null;
                      });
                    },
                  ),
                  Text(
                    'Botshabelo',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 2,
                    groupValue: fromArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Mangaung';
                        fromArea = 2;
                        fromRoute = mangaungArea;
                        this.fromValue = null;
                      });
                    },
                  ),
                  Text(
                    'Mangaung',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 3,
                    groupValue: fromArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Suburbs';
                        fromArea = 3;
                        fromRoute = suburbsArea;
                        this.fromValue = null;
                      });
                    },
                  ),
                  Text(
                    'Suburbs',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 4,
                    groupValue: fromArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Thaba Nchu';
                        fromArea = 4;
                        fromRoute = thabaNchuArea;

                        this.fromValue = null;
                      });
                    },
                  ),
                  Text(
                    'Thaba Nchu',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'From Route',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
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
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.teal[400],
                    ),
                    underline: Container(),
                    style: TextStyle(color: Colors.teal[400], fontSize: 17),
                    items: fromRoute.map(buildMenuItem).toList(),
                    onChanged: (value) =>
                        setState(() => this.fromValue = value),
                    value: this.fromValue,
                    hint: Text('Choose Route',
                        style:
                            TextStyle(color: Colors.teal[400], fontSize: 17)),
                  ),
                ),
              ]),
            ),

            Divider(height: 15, thickness: 5, color: Colors.orange[400]),
            SizedBox(height: 10),

            ///
            ///
            ///
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'To Area',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal[400],
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
                    activeColor: Colors.teal[400],
                    value: 1,
                    groupValue: toArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Botshabelo';
                        toArea = 1;
                        toRoute = botshabeloArea;
                        this.toValue = null;
                      });
                    },
                  ),
                  Text(
                    'Botshabelo',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 2,
                    groupValue: toArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Mangaung';
                        toArea = 2;
                        toRoute = mangaungArea;
                        this.toValue = null;
                      });
                    },
                  ),
                  Text(
                    'Mangaung',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 3,
                    groupValue: toArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Suburbs';
                        toArea = 3;
                        toRoute = suburbsArea;
                        this.toValue = null;
                      });
                    },
                  ),
                  Text(
                    'Suburbs',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: Colors.teal[400],
                    value: 4,
                    groupValue: toArea,
                    onChanged: (val) {
                      setState(() {
                        areaItem = 'Thaba Nchu';
                        toArea = 4;
                        toRoute = thabaNchuArea;

                        this.toValue = null;
                      });
                    },
                  ),
                  Text(
                    'Thaba Nchu',
                    style: TextStyle(
                      color: Colors.teal[400],
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'To Route',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
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
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.teal[400],
                    ),
                    underline: Container(),
                    style: TextStyle(color: Colors.teal[400], fontSize: 17),
                    items: toRoute.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => this.toValue = value),
                    value: this.toValue,
                    hint: Text('Choose Route',
                        style:
                            TextStyle(color: Colors.teal[400], fontSize: 17)),
                  ),
                ),
              ]),
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal[400],
                  fixedSize: Size(270, 60),
                ),
                onPressed: () {
                  if (fromValue == null || toValue == null) {
                    showSnackBar(context, 'Enter All Fields');
                  } else {
                    ViewBusSchedule.fromRoute = this.fromValue;
                    ViewBusSchedule.toRoute = this.toValue;
                    Navigator.pushNamed(context, RouteManager.schedule);
                    refreshSchedulesInUI(context);
                  }
                },
                child: Text(
                  'View Schedule',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ))
          ],
        ),
      ),
    );
  }
}
