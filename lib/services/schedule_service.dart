import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:cut_wil_2021/models/schedule.dart';
import 'package:cut_wil_2021/models/schedule_entry.dart';

class ScheduleService with ChangeNotifier {
  ScheduleEntry? _scheduleEntry;

  List<Schedule> _schedules = [];
  List<Schedule> get schedules => _schedules;

  // empty List for new database
  void emptySchedules() {
    _schedules = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  // Function for Getting schedules
  Future<String> getSchedules() async {
    String result = 'OK';

    // Which Row
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "show ='YES'";

    _busyRetrieving = true;
    notifyListeners();

    // Get Data from table called 'AnnoucementEntry'
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('ScheduleEntry')
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
      if (map.length > 0) {
        // {map.first} because there's only one list of schedules
        _scheduleEntry = ScheduleEntry.fromJson(map.first);
        _schedules = convertMapToScheduleList(_scheduleEntry!.schedules);
        notifyListeners();
      } else {
        emptySchedules();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  // Function for saving a schedule entry
  Future<String> saveScheduleEntry(String username, bool inUI) async {
    String result = 'OK';

    if (_scheduleEntry == null) {
      _scheduleEntry =
          ScheduleEntry(schedules: convertScheduleListToMap(_schedules));
    } else {
      _scheduleEntry!.schedules = convertScheduleListToMap(_schedules);
    }

    // Showing the busy progress
    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    // Saving the Schedule to table
    await Backendless.data
        .of('ScheduleEntry')
        .save(_scheduleEntry!.toJson())
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

  // Funtion for deleting a schedule from the List
  void deleteSchedule(Schedule schedule) {
    // A schedule is removed from the List
    _schedules.remove(schedule);
    notifyListeners();
  }

  // Funtion for inserting a schedule to the List
  void createSchedule(Schedule schedule) {
    // A schedule is inserted to the List
    _schedules.insert(0, schedule);
    notifyListeners();
  }
}
