import 'package:coffee_apps/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee_apps/services/auth.dart';
import 'package:coffee_apps/shared/loading.dart';

//create stateful widget for using the state
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String errors = "";

  @override
  Widget build(BuildContext context) {
    //ternary operator for loading

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Login to Coffee App'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              //dont use this keyword
              //use widget
              widget.toggleView();
            },
             icon: Icon(Icons.person),
            label: Text('Register'),
          ),
        ],
      ),
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/coffee_bg.png'),
          fit: BoxFit.cover,
       ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0 ,horizontal: 50.0),

      //input section
      child: Form(
        key: _formKey,
         child: Center(
           child: Column(
             children: [
               Image.asset(
                 'assets/coffee_app.png',
                 height: 100,
                 width: 100,
               ),
               SizedBox(height: 20.0),
               TextFormField(
                 //from constants.dart file
                 decoration: textInputDecoration1,
                 validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                 onChanged: (val) {
                   setState(() => email = val);
                 }
               ),
               SizedBox(height: 20.0),
               TextFormField(
                 //from constants.dart file
                 decoration: textInputDecoration2,
                 obscureText: true, //making password secure e.g "*****"
                   validator: (val) => val!.length < 6 ? 'Enter a password' : null,
                   onChanged: (val) {
                   setState(() => password = val);
                   }
               ),
               SizedBox(height: 20.0),
               ElevatedButton(
                 onPressed:() async{
                   if(_formKey.currentState!.validate()){
                     //loading screen
                     setState(() => loading = true);

                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                           errors = 'Wrong Email or Password';
                           loading = false;  //loading screen is false after null
                        });
                      }
                   }
                 },
                 child: Text('Sign in'),
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
                   textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                 ),
               ),
               SizedBox(height: 10.0),
               Text(
                 errors,
                 style: TextStyle(color: Colors.red, fontSize: 14.0),
               ),
             ],
           ),
         ),
      ),
     ),
    );
  }
}
