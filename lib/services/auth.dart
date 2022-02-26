import 'package:coffee_apps/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';  //kena import ni
import 'package:coffee_apps/models/users.dart' as u;


class AuthService {

   final FirebaseAuth _auth = FirebaseAuth.instance;

   // create user object based on User in method   FirebaseUser = User
   u.Users? _userFromFirebaseUser(User? user){
     return user != null ? u.Users(uid: user.uid) : null;
   }

   // auth change user stream
   //Firebase User is now User?
   //onAuthStateChanged is now authStateChanges()
   // auth change user stream (custom user class)
   Stream<u.Users?> get user{
     return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
         //.map((User? user) => _userFromFirebaseUser(user)); or buat mcm ni
        //.map(_userFromFirebaseUser);
   }

    //sign in anonymous
   //asynchronous task so use Future keyword
   Future signInAnon() async{
     try{
       UserCredential result  =  await _auth.signInAnonymously();
       User? user = result .user!;
       return _userFromFirebaseUser(user);
     }catch(e){
       //if errors
       print(e.toString());
       return null;
     }
   }

   //sign in with email & password
   //asynchronous task so use Future keyword
   Future signInWithEmailAndPassword(String email, String password) async {
     //signInWithEmailAndPassword(email: email, password: password); method in firebase
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user!;
      return _userFromFirebaseUser(user);
     } catch(e){
      print(e.toString());
      return null;
    }
   }

   //register with email & password
   //synchronous task so use Future keyword
   Future registerWithEmailAndPassword(String email, String password) async {
      //access database in firebase
     //createUserWithEmailAndPassword(email: email, password: password); method in firebase
     try {
       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User? user = result.user!;

       //create a new document for the user with the uid
       //sugar 0, name new crew member , strength 100
       await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

       return _userFromFirebaseUser(user);
     }catch(e){
       print(e.toString());
       return null;
     }
   }

   //sign out
   //synchronous task so use Future keyword
   Future signOut() async{
     try {
        return await _auth.signOut();
     }catch(e){
        //if errors
        print(e.toString());
        return null;
     }
   }

}