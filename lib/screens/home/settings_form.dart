import 'package:coffee_apps/models/users.dart' as u;
import 'package:coffee_apps/services/database.dart';
import 'package:coffee_apps/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_apps/shared/constants.dart';
import 'package:provider/provider.dart';

//create a stateful widget
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100,200,300,400,500,600,700,800,900];


  //form values
  String? _currentName ;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<u.Users>(context);

    return StreamBuilder<u.UserData?>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
       if(snapshot.hasData){
         u.UserData  userData = snapshot.data!;
          return Form(
           key: _formKey,
           child: Column(
             children: [
               Text(
                 'Update Settings',
                 style: TextStyle(fontSize: 18.0),
               ),
               SizedBox(height: 20.0),
               TextFormField(
                 initialValue: userData.name,
                 decoration: InputDecoration(
                   hintText: 'Name',
                   fillColor: Colors.white,
                   filled: true,
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color:  Colors.white, width: 2.0),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                   ),
                 ),
                 validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                 onChanged: (val) => setState(() => _currentName = val),
               ),
               SizedBox(height: 20.0),

               //dropdown
               DropdownButtonFormField(
                 decoration: textInputDecoration1,
                 //set the current value for sugar if not so its null
                 value: _currentSugars ?? userData.sugars,
                 items: sugar.map((sugar) {
                   return DropdownMenuItem(
                     value: sugar,
                     child: Text('$sugar spoon'),
                   );
                 }).toList(),
                 onChanged: (val) => setState(() => _currentSugars = val as String),
               ),

               SizedBox(height: 20.0),
               //slider
               Slider(
                 value: (_currentStrength ?? userData.strength).toDouble(), //convert to double
                 activeColor: Colors.brown[_currentStrength ?? userData.strength], //for color the slider  (if no current color then it will be 100)
                 inactiveColor: Colors.brown[_currentStrength ?? userData.strength],//for color the slider
                 min: 100,
                 max: 900,
                 divisions: 8,
                 //val.round() we round it from min : 100.0 and max : 900.0 (double) to (int)
                 onChanged: (val) => setState(() => _currentStrength = val.round()),
               ),

               SizedBox(height: 20.0),
               ElevatedButton(
                 onPressed: () async{
                   if(_formKey.currentState!.validate()){
                     await DatabaseService(uid: user.uid).updateUserData(
                       _currentSugars ?? userData.sugars,
                       _currentName ?? userData.name,
                       _currentStrength ?? userData.strength
                     );
                     Navigator.pop(context);
                   }
                 },
                 child: Text('Update'),
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
                   textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                 ),
               ),
             ],
           ),
         );

     }else {
       return Loading();
     }

      }
    );
  }
}
