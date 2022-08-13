import 'package:flutter/material.dart';
import 'package:cut_wil_2021/Functions/user_role.dart';
import 'package:cut_wil_2021/Routes/routes.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/services/helper_announcement.dart';
import 'package:cut_wil_2021/services/helper_user.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/announcement_card.dart';
import 'package:provider/provider.dart' as provider;

// this is the home page

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('Home', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              icon: Icon(Icons.replay_outlined),
              tooltip: 'Refresh',
              onPressed: () {
                refreshAnnouncementsInUI(context);
              }),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  boxShadow: [],
                  image: DecorationImage(
                    image: AssetImage('assets/images/Interstatelogo.jpg'),
                  ),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50)),
                ),
              ),
              SizedBox(height: 15),
              Image.asset(
                'assets/images/Covid19Image.jpg',
                scale: 0.67,
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: provider.Consumer<AnnouncementService>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.announcements.length,
                          itemBuilder: (context, index) {
                            return value.announcements[index].city ==
                                    context
                                        .read<UserService>()
                                        .currentUser!
                                        .getProperty('city')
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: Text(value
                                                .announcements[index].title),
                                            content: Text(value
                                                .announcements[index]
                                                .description),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  'Close',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                    child: AnnouncementCard(
                                      message: value.announcements[index],
                                      deletaAction: () async {
                                        context
                                            .read<AnnouncementService>()
                                            .deleteAnnouncement(
                                                value.announcements[index]);
                                      },
                                    ),
                                  )
                                : Container();
                          },
                        );
                      },
                    )),
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Background2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Container(),
            ),
            UserRole.userRole == 'commuter'
                ? commuterOps(context)
                : UserRole.userRole == 'admin'
                    ? adminOps(context)
                    : UserRole.userRole == 'driver'
                        ? driverOps(context)
                        : Container(
                            child: Text('Unknown Role'),
                          ),
          ],
        ),
      ),
    );
  }
}

Expanded commuterOps(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: Icon(Icons.payments),
          title: Text('Buy Ticket'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.buy);
          },
        ),
        ListTile(
          leading: Icon(Icons.history_edu),
          title: Text('Purchase History'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.boughtHistory);
          },
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text('Balance Details'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.balanceDetails);
          },
        ),
        ListTile(
          leading: Icon(Icons.schedule),
          title: Text('View Schedule'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.chooseBusRoute);
          },
        ),
        ListTile(
          leading: Icon(Icons.announcement),
          title: Text('Annoucements'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.announcements);
          },
        ),
        ListTile(
          leading: Icon(Icons.preview_outlined),
          title: Text('View Profile'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.profile);
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.messages);
          },
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Log out'),
          onTap: () {
            logoutUserInUI(context);
          },
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
      ],
    ),
  );
}

Expanded adminOps(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: Icon(Icons.history_edu),
          title: Text('Commuter History'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.userTickets);
          },
        ),
        ListTile(
          leading: Icon(Icons.schedule),
          title: Text('Write Schedule'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.writeSchedule);
          },
        ),
        ListTile(
          leading: Icon(Icons.schedule),
          title: Text('View Schedule'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.chooseBusRoute);
          },
        ),
        ListTile(
          leading: Icon(Icons.announcement),
          title: Text('Annoucements'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.announcements);
          },
        ),
        ListTile(
          leading: Icon(Icons.preview_outlined),
          title: Text('View Profile'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.profile);
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.messages);
          },
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Log out'),
          onTap: () {
            logoutUserInUI(context);
          },
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
      ],
    ),
  );
}

Expanded driverOps(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: Icon(Icons.schedule),
          title: Text('View Schedule'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.chooseBusRoute);
          },
        ),
        ListTile(
          leading: Icon(Icons.announcement),
          title: Text('Annoucements'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.announcements);
          },
        ),
        ListTile(
          leading: Icon(Icons.preview_outlined),
          title: Text('View Profile'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.profile);
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
          onTap: () {
            Navigator.of(context).pushNamed(RouteManager.messages);
          },
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Log out'),
          onTap: () {
            logoutUserInUI(context);
          },
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
      ],
    ),
  );
}
