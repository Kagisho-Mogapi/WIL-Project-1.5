class Announcement {
  final String title;
  final String description;
  final String level;
  final DateTime created;
  final String city;

  Announcement({
    required this.title,
    required this.description,
    required this.level,
    required this.created,
    required this.city,
  });

  // Convert Map to Json
  Map<String, Object?> toJson() => {
        'title': title,
        'description': description,
        'level': level,
        'created': created.millisecondsSinceEpoch,
        'city': city,
      };

  // Convert Json to Map
  static Announcement fromJson(Map<dynamic, dynamic>? json) => Announcement(
        title: json!['title'] as String,
        description: json['description'] as String,
        level: json['level'] as String,
        city: json['city'] as String,
        created: DateTime.fromMillisecondsSinceEpoch(
            (json['created'] as double).toInt()),
      );

  // Checks for title duplicates
  @override
  bool operator ==(covariant Announcement announcement) {
    return (this
            .title
            .toUpperCase()
            .compareTo(announcement.title.toUpperCase()) ==
        0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}

// Convert List of Announcement to Map of Announcements
Map<dynamic, dynamic> convertAnnouncementListToMap(
    List<Announcement> announcements) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < announcements.length; i++) {
    map.addAll({'$i': announcements[i].toJson()});
  }
  return map;
}

// Convert Map of Announcements to List of Announcement
List<Announcement> convertMapToAnnouncementList(Map<dynamic, dynamic> map) {
  List<Announcement> announcements = [];
  for (var i = 0; i < map.length; i++) {
    announcements.add(Announcement.fromJson(map['$i']));
  }
  return announcements;
}
