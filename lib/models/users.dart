

class Users {

  final String? uid;

  //constructor with named parameter
  Users({this.uid});

}

class UserData {

  final String? uid;
  final String name;
  final String sugars;
  final int strength;

  //constructor with named parameter
  UserData({ this.uid,required this.name, required this.sugars, required this.strength });

}