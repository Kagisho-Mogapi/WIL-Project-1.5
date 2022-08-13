import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/services/helper_announcement.dart';
import 'package:cut_wil_2021/widgets/app_progress_indicator.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart' as provider;

// A page that will allow an admin to write an announcemnt

class CreateAnnouncement extends StatefulWidget {
  const CreateAnnouncement({Key? key}) : super(key: key);

  @override
  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  late TextEditingController titleController;
  late TextEditingController announcementController;

  final List<String> administrators = [
    'Administrator',
    'Bus Driver',
    'Commuter',
  ];

  final List<String> city = [
    'Bloemfontein',
    'Botshabelo',
    'Thaba Nchu',
  ];

  String? recipient;
  String? cityValue;
  DropdownMenuItem<String> buildMenuItem(String admin) => DropdownMenuItem(
      value: admin,
      child: Text(
        admin,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ));

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    announcementController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    announcementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Write announcement'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.orangeAccent,
      body: Stack(
        children: <Widget>[
          //
          Container(
            height: MediaQuery.of(context).size.height - 82.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
          ),
          Positioned(
              top: 80.0,
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
            //child: Container(
            //height: 1000,
            //width: 1000,
            //decoration: waterDeepDeco(),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    height: 15,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Announcement',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
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
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.teal[400],
                                ),
                                underline: Container(),
                                style: TextStyle(
                                    color: Colors.teal[400], fontSize: 17),
                                onChanged: (value) => setState(
                                    () => this.recipient = value as String),
                                value: recipient,
                                items:
                                    administrators.map(buildMenuItem).toList(),
                                iconSize: 20,
                                hint: Text('Choose recipient',
                                    style: TextStyle(
                                        color: Colors.teal[400], fontSize: 17)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 0),
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
                                  style: TextStyle(
                                      color: Colors.teal[400], fontSize: 17),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.teal[400],
                                  ),
                                  underline: Container(),
                                  items: city.map(buildMenuItem).toList(),
                                  onChanged: (value) =>
                                      setState(() => this.cityValue = value),
                                  value: this.cityValue,
                                  hint: Text('Choose city',
                                      style: TextStyle(
                                          color: Colors.teal[400],
                                          fontSize: 17)),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Focus(
                            onFocusChange: (value) {
                              if (!value) {
                                AnnouncementService.fromCreateAnnouncement =
                                    true;
                                context
                                    .read<AnnouncementService>()
                                    .getAnnouncements(recipient!);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Colors.teal.shade400,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.teal[400]),
                                  controller: titleController,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintStyle:
                                        TextStyle(color: Colors.teal[400]),
                                    border: InputBorder.none,
                                    hintText: 'Write Announcement title',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.teal.shade400,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 19, color: Colors.teal[400]),
                                controller: announcementController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.teal[400]),
                                  border: InputBorder.none,
                                  hintText: 'Write Announcement Description',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        if (recipient == null ||
                            cityValue == null ||
                            announcementController.text.trim().isEmpty ||
                            titleController.text.trim().isEmpty) {
                          showSnackBar(context, 'Please Enter All Fields');
                        } else {
                          // Are they both needed?
                          context
                              .read<AnnouncementService>()
                              .getAnnouncements(recipient!);
                          createNewAnnouncementInUI(context,
                              titleController: titleController,
                              descriptionController: announcementController,
                              recepientController: recipient!,
                              cityController: cityValue!);
                          saveAllAnnouncementsInUI(context, recipient!);
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
          provider.Selector<AnnouncementService, bool>(
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
