class User {
  final String email;

  User({required this.email});

// Convert Map to Json
  Map<String, Object?> toJson() => {
        'email': email,
      };

// Convert Json to Map
  static User fromJson(String email) => User(
        email: email,
      );
}

// Convert List of Users to Map of Users
Map<dynamic, dynamic> convertUserListToMap(List<User> users) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < users.length; i++) {
    map.addAll({'$i': users[i].toJson()});
  }
  return map;
}

// Convert Map of Users to List of Users
String convertMapToUserList(String email) {
  List<User> users = [];

  users.add(User.fromJson(email));

  return email;
}
