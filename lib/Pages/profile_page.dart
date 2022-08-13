import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/widgets/elevated_btn_a.dart';
import 'package:cut_wil_2021/widgets/get_profile_details.dart';

// This page will allow a user to view their profile details

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My profile'),
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.pushNamed(context, RouteManager.newHome);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.black54,
      body: Container(
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        ProfileDetails(
                            detailHeader: 'First Name', detailName: 'fName'),
                        SizedBox(height: 15),
                        ProfileDetails(
                            detailHeader: 'Last Name', detailName: 'lName'),
                        SizedBox(height: 15),
                        ProfileDetails(
                            detailHeader: 'ID Number', detailName: 'idNumber'),
                        SizedBox(height: 15),
                        ProfileDetails(
                            detailHeader: 'Email', detailName: 'email'),
                        SizedBox(height: 15),
                        ProfileDetails(
                            detailHeader: 'Phone Number',
                            detailName: 'phoneNumber'),
                        SizedBox(height: 15),
                        ProfileDetails(
                            detailHeader: 'City', detailName: 'city'),
                        SizedBox(height: 30),
                      ],
                    ),
                    MyElevatedBtnA(
                      btnName: 'Edit Profile',
                      routeName: RouteManager.editProfile,
                      getMeSome: '',
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
