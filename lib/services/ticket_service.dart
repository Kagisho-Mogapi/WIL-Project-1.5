import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:cut_wil_2021/models/ticket.dart';
import 'package:cut_wil_2021/models/ticket_entry.dart';

class TicketService with ChangeNotifier {
  TicketEntry? _ticketEntry;

  List<Ticket> _tickets = [];
  List<Ticket> get tickets => _tickets;

  void emptyTickets() {
    _tickets = [];
    notifyListeners();
  }

  TicketEntry? _otherTicketEntry;

  List<Ticket> _otherTickets = [];
  List<Ticket> get otherTickets => _otherTickets;

  // empty List for new database
  void emptyOtherTickets() {
    _otherTickets = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  // Function for Getting current user tickets
  Future<String> getTickets(String username) async {
    String result = 'OK';
    // username = UserService.userEmail;

    // Which username's Row
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username ='$username'";

    _busyRetrieving = true;
    notifyListeners();

    // Get Data from table called 'AnnoucementEntry'
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('TicketEntry')
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
        // !!!! {map.first} because there's only one list per user !!!!!!!!!
        _ticketEntry = TicketEntry.fromJson(map.first);
        _tickets = convertMapToTicketList(_ticketEntry!.tickets);
        notifyListeners();
      } else {
        emptyTickets();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  // Function for saving a ticket entry to current user
  Future<String> saveTicketEntry(String username, bool inUI) async {
    String result = 'OK';

    if (_ticketEntry == null) {
      _ticketEntry = TicketEntry(
          tickets: convertTicketListToMap(_tickets), username: username);
    } else {
      _ticketEntry!.tickets = convertTicketListToMap(_tickets);
    }

    // Showing the busy progress
    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    // Saving the Ticket to table
    await Backendless.data
        .of('TicketEntry')
        .save(_ticketEntry!.toJson())
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

  // Function for Getting another user tickets
  Future<String> getOtherTickets(String username) async {
    String result = 'OK';
    // username = UserService.userEmail;

    // Which username's Row
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username ='$username'";

    _busyRetrieving = true;
    notifyListeners();

    // Get Data from table called 'AnnoucementEntry'
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('TicketEntry')
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
        // {map.first} because there's only one list per user
        _otherTicketEntry = TicketEntry.fromJson(map.first);
        _otherTickets = convertMapToTicketList(_otherTicketEntry!.tickets);
        notifyListeners();
      } else {
        emptyOtherTickets();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  // Function for saving a ticket entry to another user
  Future<String> saveOtherTicketEntry(String username, bool inUI) async {
    String result = 'OK';

    if (_otherTicketEntry == null) {
      _otherTicketEntry = TicketEntry(
          tickets: convertTicketListToMap(_otherTickets), username: username);
    } else {
      _otherTicketEntry!.tickets = convertTicketListToMap(_otherTickets);
    }

    // Showing the busy progress
    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    // Saving the Ticket to table
    await Backendless.data
        .of('TicketEntry')
        .save(_otherTicketEntry!.toJson())
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

  // Funtion for deleting a ticket from the List
  void deleteTicket(Ticket ticket) {
    // A ticket is removed from the List
    _tickets.remove(ticket);
    notifyListeners();
  }

  // Funtion for inserting a ticket to the List
  void createTicket(Ticket ticket) {
    // A ticket is inserted to the List
    _tickets.insert(0, ticket);
    notifyListeners();
  }

  // Funtion for inserting a ticket to the List of another user
  void createOtherTicket(Ticket ticket) {
    // A ticket is inserted to the List of another user
    _otherTickets.insert(0, ticket);
    notifyListeners();
  }
}
