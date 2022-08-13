import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cut_wil_2021/models/announcement.dart';
import 'package:cut_wil_2021/services/announcement_service.dart';
import 'package:cut_wil_2021/widgets/snack_bars.dart';
import 'package:provider/provider.dart';

// Function for getting the latest announcements
void refreshAnnouncementsInUI(BuildContext context) async {
  // "getAnnouncements" will be called to get the latest announcements
  String result =
      await context.read<AnnouncementService>().getAnnouncements('');

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data Succefully Loaded!!!');
  }
}

// Function for creating a new announcement with provide details
void createNewAnnouncementInUI(
  BuildContext context, {
  required TextEditingController titleController,
  required TextEditingController descriptionController,
  required String recepientController,
  required String cityController,
}) async {
  if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
    showSnackBar(context, 'Please Enter Announcement First!!');
  } else {
    Announcement announcement = Announcement(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        level: recepientController.trim(),
        city: cityController.trim(),
        created: DateTime.now());

    // Check for title duplicate
    if (context
        .read<AnnouncementService>()
        .announcements
        .contains(announcement)) {
      showSnackBar(context, 'Announcement Title Already Exist, Change Title');
    } else {
      //The newly created Announcemnt is sent to Announcemnt Service to
      //be saved on the database
      titleController.text = '';
      descriptionController.text = '';
      context.read<AnnouncementService>().createAnnouncement(announcement);
      Navigator.pop(context);
    }
  }
}

// Function for saving announecement that would be displayed on the UI
void saveAllAnnouncementsInUI(BuildContext context, String recipient) async {
  String result = await context
      .read<AnnouncementService>()
      .saveAnnouncementEntry(recipient, true);

  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Announcement Saved!!!');
  }
}
