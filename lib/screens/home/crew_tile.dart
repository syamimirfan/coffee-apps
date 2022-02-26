import 'package:flutter/material.dart';
import 'package:coffee_apps/models/crew.dart';

//create stateless widget
class CrewTile extends StatelessWidget {

  final Crew crew;

  //Constructor with named parameter
  CrewTile( { required this.crew} );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown[crew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(crew.name),
          subtitle: Text('Pick ${crew.sugars} spoon(s) of sugar'),
        ),
      ),
    );
  }
}
