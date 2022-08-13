class AnnouncementEntry {
  Map<dynamic, dynamic> announcements;
  String? objectId;
  AnnouncementEntry({
    required this.announcements,
    this.objectId,
  });

  // Converts the announcements Map to Json
  Map<String, Object?> toJson() => {
        'announcements': announcements,
        'objectId': objectId,
      };

  // Converts the announcements Json to Map
  static AnnouncementEntry fromJson(Map<dynamic, dynamic>? json) =>
      AnnouncementEntry(
        announcements: json!['announcements'] as Map<dynamic, dynamic>,
        objectId: json['objectId'] as String,
      );
}
