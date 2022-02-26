import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //access data from stream
import 'package:coffee_apps/models/crew.dart';
import 'package:coffee_apps/screens/home/crew_tile.dart';

//create stateful widget
class CrewList extends StatefulWidget {

  @override
  _CrewListState createState() => _CrewListState();
}

class _CrewListState extends State<CrewList> {
  @override
  Widget build(BuildContext context) {

    final crews = Provider.of<List<Crew>>(context);

    //forEach loop
    // crews.forEach((crew) {
    //    print(crew.name);
    //    print(crew.sugars);
    //    print(crew.strength);
    // });

    return ListView.builder(
      itemCount: crews.length,
      itemBuilder: (context, index) {
        //index must start with 0
        return CrewTile(crew: crews[index]);
      },
    );
  }
}
