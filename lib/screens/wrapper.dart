import 'package:coffee_apps/screens/authenticate/authenticate.dart';
import 'package:coffee_apps/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_apps/models/users.dart' as u;

//create stateless widget
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<u.Users?>(context);

    //return either Home or Authenticate
    if(user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
