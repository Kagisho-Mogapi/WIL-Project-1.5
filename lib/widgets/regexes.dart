class MyRegexes {
  static String number = r'^[0-9]+$';
  static String phonenumber = r'^(\+27|0)[6-8][0-9]{8}$';
  static String name = r'^[a-z A-Z]+$';
  static String email = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  //Minimum eight characters, at least one letter, one number and one special character
  static String password =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
  static String time = r'^([0-1][0-9]|[2][0-3]):([0-5][0-9])$';
  static String idNumber =
      r'(?<Year>[0-9][0-9])(?<Month>([0][1-9])|([1][0-2]))(?<Day>([0-2][0-9])|([3][0-1]))(?<Gender>[0-9])(?<Series>[0-9]{3})(?<Citizenship>[0-9])(?<Uniform>[0-9])(?<Control>[0-9])';
}
