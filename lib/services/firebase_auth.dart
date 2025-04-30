import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthentication {
  static Future<String> loginWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return ' you enterd Wrong password ';
      }
    }
    return '';
  }

  static Future<String> registerWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then((_) async {
        return 'account created succesfully';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        return 'The password provided is too weak.';

        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        return 'The account already exists for that email.';
      }
      return '';
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  static Future<String> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      // Optional: Specify the scopes you need
      scopes: <String>['email'],
    );

    try {
      // Trigger the sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain auth details from the Sign-in
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential

      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseFirestoreData.addUser(
          fullName: user.user!.displayName!,
          email: user.user!.email!,
          password: '',
          photoUrl: user.user!.photoURL!);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user_name', user.user!.displayName!);
      prefs.setString('profile_photo', user.user!.photoURL.toString());
      // Do something with the user
      return 'Successfully completed';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (await googleSignIn.isSignedIn()) {
        print('google sign in');
        await googleSignIn.signOut();

        return 'Succesfully sign out';
      } else {
        await FirebaseAuth.instance.signOut().then((onValue) async {
          // ignore: use_build_context_synchronously
          return 'Succesfully sign out';
        });
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  static Future<String> resetPassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;

    user?.updatePassword(newPassword).then((onValue) {
      //Success, do something
      return 'Successfully changed your password';
    }).catchError((error) {
      //Error, show something
      // ignore: invalid_return_type_for_catch_error
      return error.toString;
    });

    return '';
  }
}
