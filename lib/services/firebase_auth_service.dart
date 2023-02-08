import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


Future<void> createUser(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      debugPrint('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> signInFirebaseEmail(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      debugPrint('Email não cadastrado');
    } else if (e.code == 'wrong-password') {
      debugPrint('Email ou senha incorretos.');
    }
  }
}