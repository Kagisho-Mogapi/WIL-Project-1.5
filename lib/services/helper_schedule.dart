import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/models/schedule.dart';
import 'package:cut_wil_2021/services/schedule_service.dart';
import 'package:cut_wil_2021/services/user_service.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart';

// Function for getting the latest schedules
void refreshSchedulesInUI(BuildContext context) async {
  // "getSchedules" will be called to get the latest schedules
  String result = await context.read<ScheduleService>().getSchedules();

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data Succefully Loaded!!!');
  }
}

void createNewScheduleInUI(
  BuildContext context, {
  required String fromController,
  required String toController,
  required String minuteController,
  required String hourController,
  required String busCodeController,
  required String dayOfWeekController,
}) async {
  if (fromController.isEmpty ||
      toController.isEmpty ||
      minuteController.isEmpty ||
      hourController.isEmpty ||
      busCodeController.isEmpty ||
      dayOfWeekController.isEmpty) {
    showSnackBar(context, 'Please Enter All Fields First!!');
  } else {
    Schedule schedule = Schedule(
        from: fromController.trim(),
        to: toController.trim(),
        minute: minuteController.trim(),
        hour: hourController.trim(),
        dayOfWeek: dayOfWeekController.trim(),
        busCode: busCodeController.trim());

    //The newly created Schedule is sent to Schedule Service to
    //be saved on the database
    context.read<ScheduleService>().createSchedule(schedule);
    Navigator.pop(context);
  }
}

// Function for saving schedules that would be displayed on the UI
void saveAllSchedulesInUI(BuildContext context) async {
  String result = await context
      .read<ScheduleService>()
      .saveScheduleEntry(context.read<UserService>().currentUser!.email, true);

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Schedule Saved!!!');
  }
}
