import 'package:coffee_apps/screens/home/crew_list.dart';
import 'package:coffee_apps/screens/home/settings_form.dart';
import 'package:coffee_apps/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_apps/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee_apps/models/crew.dart';

//create stateless widget
class Home extends StatelessWidget {

  //create auth.dart instance
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Crew>>.value(
      initialData: [],
      value: DatabaseService().crews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Coffee Crew'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
            FlatButton.icon(
              onPressed: () async{
                  await  _auth.signOut();
               },
              icon: Icon(Icons.person),
              label: Text('logout'),
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
            child: CrewList()
        ) ,
      ),
    );
  }
}
