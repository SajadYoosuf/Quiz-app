import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthentication {
  static User? get user => FirebaseAuth.instance.currentUser;

  static Future<String> loginWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return 'successfully login';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'You entered the wrong password.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        default:
          return 'Authentication failed: ${e.message}';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  static Future<String> registerWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return 'account created succesfully';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled.';
        default:
          return 'Registration failed: ${e.message}';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  static Future<String> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      // Optional: Specify the scopes you need
      scopes: <String>['email'],
    );

    try {
      // Trigger the sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // User canceled the sign-in flow
      if (googleUser == null) {
        return 'Sign-in was canceled';
      }

      // Obtain auth details from the Sign-in
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Save user data to Firestore
      if (userCredential.user != null) {
        final user = userCredential.user!;
        await FirebaseFirestoreData.addUser(
          user.displayName ?? 'User',
          user.email ?? '',
          '',
          user.photoURL ?? '',
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            FirebaseKeys.userName, user.displayName ?? 'User');
      }

      return 'Successfully completed';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      await FirebaseAuth.instance.signOut();
      return 'Succesfully sign out';
    } catch (e) {
      return 'Error signing out${e.toString()}';
    }
  }

  static Future<String> resetPassword(String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return 'No user is currently signed in';
      }

      await user.updatePassword(newPassword);
      //Success, do something
      return 'Successfully changed your password';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'requires-recent-login':
          return 'This operation is sensitive and requires recent authentication. Please log in again.';
        default:
          return 'Password reset failed: ${e.message}';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }
}
