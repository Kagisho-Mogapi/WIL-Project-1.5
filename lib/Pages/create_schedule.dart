import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/schedule_service.dart';
import 'package:cut_wil_2021/services/helper_schedule.dart';
import 'package:cut_wil_2021/widgets/app_progress_indicator.dart';
import 'package:cut_wil_2021/widgets/regexes.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart' as provider;

// A page that will allow an admin to write a bus schedule

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({Key? key}) : super(key: key);

  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController busCodeController = TextEditingController();

  String? value1;
  String? value2;
  String? value3;
  String? value4;
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
  int fromID = 1;
  int fromArea = 1;
  int toID = 1;
  int toArea = 1;

  final items = ['Route 1', 'Route 2', 'Route 3'];
  String? value;
  String dayOfTheWeek = 'Mondays to Fridays';
  String areaItem = 'Botshabelo';
  int id = 1;
  int area = 1;

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  @override
  void dispose() {
    toController.dispose();
    fromController.dispose();
    hourController.dispose();
    minuteController.dispose();
    busCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text(
            'Write a schedule',
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
      //backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
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
                              dayOfTheWeek = 'Mondays to Fridays';
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
                              dayOfTheWeek = 'Saturdays';
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
                              dayOfTheWeek = 'Sundays';
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
                              style: TextStyle(
                                  color: Colors.teal[400], fontSize: 17),
                              items: fromRoute.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => this.fromValue = value),
                              value: this.fromValue,
                              hint: Text('Choose Route',
                                  style: TextStyle(
                                      color: Colors.teal[400], fontSize: 17)),
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
                              style: TextStyle(
                                  color: Colors.teal[400], fontSize: 17),
                              items: toRoute.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => this.toValue = value),
                              value: this.toValue,
                              hint: Text('Choose Route',
                                  style: TextStyle(
                                      color: Colors.teal[400], fontSize: 17)),
                            ),
                          ),
                        ]),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, bottom: 10, left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.teal[400]),
                            controller: hourController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.teal[400]),
                                hintText: 'Hour'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            ':',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.teal[400]),
                            controller: minuteController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.teal[400]),
                                hintText: 'Minute'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 7),
                        child: Text(
                          'Upload',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      onPressed: () {
                        if (timeIsValid(hourController.text.trim(),
                            minuteController.text.trim())) {
                          showSnackBar(context, 'Invalid Time');
                        } else {
                          if (fromValue == null ||
                              toValue == null ||
                              minuteController.text.trim().isEmpty ||
                              hourController.text.trim().isEmpty) {
                            showSnackBar(context, 'Please Enter All Fields!!');
                          } else {
                            // Are they both needed?
                            createNewScheduleInUI(context,
                                fromController: fromValue!,
                                toController: toValue!,
                                minuteController: minuteController.text.trim(),
                                hourController: hourController.text.trim(),
                                dayOfWeekController: dayOfTheWeek,
                                busCodeController: toValue!);
                            saveAllSchedulesInUI(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[400],
                        fixedSize: Size(270, 60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          provider.Selector<ScheduleService, bool>(
            selector: (context, value) => value.busySaving,
            builder: (context, value, child) {
              return value
                  ? AppProgressIndicator(
                      text: 'Saving data To the database... Please wait...')
                  : Container();
            },
          )
        ],
      ),
    );
  }
}

bool timeIsValid(String hour, String minute) {
  bool isValid = true;
  String time = hour + ':' + minute;

  if (RegExp(MyRegexes.time).hasMatch(time)) {
    isValid = false;
  }
  return isValid;
}
