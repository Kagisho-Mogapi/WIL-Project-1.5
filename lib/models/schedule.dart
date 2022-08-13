class Schedule {
  final String from;
  final String to;
  final String hour;
  final String minute;
  final String busCode;
  final String dayOfWeek;

  Schedule({
    required this.from,
    required this.to,
    required this.minute,
    required this.hour,
    required this.busCode,
    required this.dayOfWeek,
  });
// Convert Map to Json
  Map<String, Object?> toJson() => {
        'from': from,
        'to': to,
        'minute': minute,
        'hour': hour,
        'dayOfWeek': dayOfWeek,
        'busCode': busCode,
      };
// Convert Json to Map
  static Schedule fromJson(Map<dynamic, dynamic>? json) => Schedule(
        from: json!['from'] as String,
        to: json['to'] as String,
        minute: json['minute'] as String,
        hour: json['hour'] as String,
        dayOfWeek: json['dayOfWeek'] as String,
        busCode: json['busCode'] as String,
      );
}

// Convert List of Schedule to Map of Schedule
Map<dynamic, dynamic> convertScheduleListToMap(List<Schedule> schedules) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < schedules.length; i++) {
    map.addAll({'$i': schedules[i].toJson()});
  }
  return map;
}

// Convert Map of Schedule to List of Schedule
List<Schedule> convertMapToScheduleList(Map<dynamic, dynamic> map) {
  List<Schedule> schedules = [];
  for (var i = 0; i < map.length; i++) {
    schedules.add(Schedule.fromJson(map['$i']));
  }
  return schedules;
}
