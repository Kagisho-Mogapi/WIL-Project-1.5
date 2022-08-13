import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:cut_wil_2021/Functions/user_role.dart';
import 'package:cut_wil_2021/models/announcement.dart';
import 'package:cut_wil_2021/models/announcement_entry.dart';

class AnnouncementService with ChangeNotifier {
  AnnouncementEntry? _announcementEntry;

  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  // Level of announcement
  String levelEveryone = "level ='everyone'";
  String levelBusDriver = "level ='busDriver'";
  String levelAdmin = "level ='admin'";
  String level = '';
  static bool fromCreateAnnouncement = false;

  // empty List for new users
  void emptyAnnouncements() {
    _announcements = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  // Function for Getting announcements
  Future<String> getAnnouncements(String recipient) async {
    String result = 'OK';

    // Checks if function is called from initial load or
    // from writing an announcement then assign a query accordingly
    if (fromCreateAnnouncement) {
      if (recipient == 'Administrator') {
        level = levelAdmin;
      } else if (recipient == 'Bus Driver') {
        level = levelBusDriver;
      } else {
        level = levelEveryone;
      }
      fromCreateAnnouncement = false;
    } else {
      if (UserRole.userRole == 'admin') {
        level = levelAdmin;
      } else if (UserRole.userRole == 'driver') {
        level = levelBusDriver;
      } else {
        level = levelEveryone;
      }
    }

    // Specify which Row
    DataQueryBuilder queryBuilder = DataQueryBuilder()..whereClause = level;
    print(level);

    _busyRetrieving = true;
    notifyListeners();

    // Get Data from table called 'AnnoucementEntry' with the above query
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('AnnouncementEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    // if theres an error it will stop here
    if (result != 'OK') {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }

    if (map != null) {
      // if "map" is not empty
      if (map.length > 0) {
        _announcementEntry = AnnouncementEntry.fromJson(map.first);
        _announcements =
            convertMapToAnnouncementList(_announcementEntry!.announcements);
        notifyListeners();
      }
      // else is for when "map" is empty
      else {
        emptyAnnouncements();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  // Function for saving an announcement entry
  Future<String> saveAnnouncementEntry(String username, bool inUI) async {
    String result = 'OK';

    if (_announcementEntry == null) {
      _announcementEntry = AnnouncementEntry(
          announcements: convertAnnouncementListToMap(_announcements));
    } else {
      _announcementEntry!.announcements =
          convertAnnouncementListToMap(_announcements);
    }

    // Showing the busy progress
    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    // Saving the Announcement to table
    await Backendless.data
        .of('AnnouncementEntry')
        .save(_announcementEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });

    // Closing the busy progress
    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }
    return result;
  }

  // Funtion for deleting an announcement from a List
  void deleteAnnouncement(Announcement announcement) {
    // An announcement is removed from the List
    _announcements.remove(announcement);
    notifyListeners();
  }

  // Funtion for inserting an announcement to the List
  void createAnnouncement(Announcement announcement) {
    // An announcement is inserted from the List
    _announcements.insert(0, announcement);
    notifyListeners();
  }
}
