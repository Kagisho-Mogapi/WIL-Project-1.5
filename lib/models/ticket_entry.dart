class TicketEntry {
  Map<dynamic, dynamic> tickets;
  String username;
  String? objectId;

  TicketEntry({
    required this.tickets,
    required this.username,
    this.objectId,
  });

  // Converts the tickets Map to Json
  Map<String, Object?> toJson() => {
        'username': username,
        'tickets': tickets,
        'objectId': objectId,
      };

  // Converts the tickets Json to Map
  static TicketEntry fromJson(Map<dynamic, dynamic>? json) => TicketEntry(
        username: json!['username'] as String,
        tickets: json['tickets'] as Map<dynamic, dynamic>,
        objectId: json['objectId'] as String,
      );
}
