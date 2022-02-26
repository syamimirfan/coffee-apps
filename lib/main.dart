import 'package:coffee_apps/models/users.dart' as u;
import 'package:coffee_apps/screens/wrapper.dart';
import 'package:coffee_apps/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //provider in root (StreamProvider.value)
    return StreamProvider<u.Users?>.value(
        initialData: null,
      //create instance for class AuthService
      value: AuthService().user,
      child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}
