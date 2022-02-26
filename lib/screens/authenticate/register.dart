import 'package:coffee_apps/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_apps/services/auth.dart';
import 'package:coffee_apps/shared/constants.dart';
import 'package:coffee_apps/shared/loading.dart';

//create a stateful widget
class Register extends StatefulWidget {

  final Function toggleView;
  Register({ required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String errors = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
       backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register to Coffee App'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              //dont use this keyword
              //use widget
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Login'),
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
          //set the key to GlobalKey
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
                    obscureText: true,
                  //check it is valid or not
                  validator: (val) => val!.length < 6 ? 'Enter a password more 6 characters' : null,
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

                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                       if(result == null){
                         setState(() {
                           errors = 'Please enter a valid email';
                           loading = false;  //loading screen is false after null
                         });
                       }
                    }
                  },
                  child: Text('Sign Up'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  errors,
                  style: TextStyle(color : Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
