/*import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Authenticate {

   Future<String> log_in(String email, String password);


   Future<String> create_account(String email, String password);

    Future<String> getAccount();

    Future<void> signOut();




}

class Auth implements Authenticate {
   final FirebaseAuth _fbAuth = FirebaseAuth.instance;

   Future<String> getAccount() async {


       FirebaseUser user = await _fbAuth.currentUser();


     return user.uid;

   }


  Future<void> signOut() async {


     return _fbAuth.signOut();

      }
   Future<String> create_account(String email, String password) async {


      FirebaseUser fb = await _fbAuth.createUserWithEmailAndPassword(email: email, password: password);

      return fb.uid;
  }



  Future<String> log_in(String email, String password) async {

     FirebaseUser fb = await _fbAuth.signInWithEmailAndPassword(email: email, password: password);

    return fb.uid;

    }




}*/