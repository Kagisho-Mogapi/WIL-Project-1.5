class ScheduleEntry {
  Map<dynamic, dynamic> schedules;
  String? objectId;

  ScheduleEntry({
    required this.schedules,
    this.objectId,
  });

  // Converts the schedules Map to Json
  Map<String, Object?> toJson() => {
        'schedules': schedules,
        'objectId': objectId,
      };

  // Converts the schedules Json to Map
  static ScheduleEntry fromJson(Map<dynamic, dynamic>? json) => ScheduleEntry(
        schedules: json!['schedules'] as Map<dynamic, dynamic>,
        objectId: json['objectId'] as String,
      );
}
