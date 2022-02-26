import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_apps/models/crew.dart';
import 'package:coffee_apps/models/users.dart';

class DatabaseService {

  final String? uid;

  //constructor
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference crewCollection = FirebaseFirestore.instance.collection('crew');

  //asynchronous use Future keyword
  //past it in settings_form.dart after user clicked 'Update'
  Future updateUserData(String sugars, String name, int strength) async{
    //uid = unique id
    //document = doc
    //setData = set
     return await crewCollection.doc(uid).set({
       'sugars': sugars,
       'name': name,
       'strength': strength,
     });
  }

  //crew list from snapshot
  List<Crew> _crewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Crew(
        //if not exist return null
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0'
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']
    );
  }

  //get crew stream
  Stream<List<Crew>> get crews{
    //snapshot() class has been build in cloud_firestore package
     return crewCollection.snapshots().map(_crewListFromSnapshot);
  }

  Stream<UserData> get userData{
    return crewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
