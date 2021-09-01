import 'package:chat_app/widgets/Auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String password, String username, bool isLogin, BuildContext ctx) async{

    UserCredential authResult;

    try {
      if (isLogin){
         authResult = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
      }

    } on FirebaseAuthException catch (e) {
      String message = "error Occurred";

      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
