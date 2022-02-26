import 'package:coffee_apps/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:coffee_apps/screens/authenticate/sign_in.dart';

//create stateful widget
class Authenticate extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    //reverse showSignIn(false) by using !
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return SignIn(toggleView: toggleView); //pass in constructor
    }else{
      return Register(toggleView : toggleView); //pass in constructor
    }
  }
}
