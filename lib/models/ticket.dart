class Ticket {
  final String ticketOwner;
  final String ticketType;
  final String isUsed;
  final String price;
  final DateTime created;

  Ticket(
      {required this.ticketOwner,
      required this.ticketType,
      required this.created,
      required this.isUsed,
      required this.price});
  // Convert Map to Json
  Map<String, Object?> toJson() => {
        'ticketOwner': ticketOwner,
        'ticketType': ticketType,
        'isUsed': isUsed,
        'price': price,
        'created': created.millisecondsSinceEpoch,
      };
  // Convert Json to Map
  static Ticket fromJson(Map<dynamic, dynamic>? json) => Ticket(
        ticketOwner: json!['ticketOwner'] as String,
        ticketType: json['ticketType'] as String,
        isUsed: json['isUsed'] as String,
        price: json['price'] as String,
        created: DateTime.fromMillisecondsSinceEpoch(
          (json['created'] as double).toInt(),
        ),
      );
}

// Convert List tickets to Map of tickets
Map<dynamic, dynamic> convertTicketListToMap(List<Ticket> tickets) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < tickets.length; i++) {
    map.addAll({'$i': tickets[i].toJson()});
  }
  return map;
}

// Convert Map of tickets to List of tickets
List<Ticket> convertMapToTicketList(Map<dynamic, dynamic> map) {
  List<Ticket> tickets = [];
  for (var i = 0; i < map.length; i++) {
    tickets.add(Ticket.fromJson(map['$i']));
  }
  return tickets;
}
