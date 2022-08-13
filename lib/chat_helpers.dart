import 'dart:math';

import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

abstract class Helpers {
  static final random = Random();

  // This function will get a channel's name, which is the name of that persion
  static String getChannelName(Channel channel, User currentUser) {
    if (channel.name != null) {
      return channel.name!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.name ?? 'No name';
      } else {
        return 'Multiple users';
      }
    } else {
      return 'No Channel Name';
    }
  }

  // This function will get a channel's image, which is an image of that persion
  static String? getChannelImage(Channel channel, User currentUser) {
    if (channel.image != null) {
      return channel.image!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.image;
      }
    } else {
      return null;
    }
  }
}
