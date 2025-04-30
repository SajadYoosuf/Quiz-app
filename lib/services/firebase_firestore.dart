import 'package:quiz_app/utilities/firebase_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreData {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static List<String> userData = [];
  static Future<String?> addUser(
      {required String fullName,
      required String email,
      required String password,
      required String photoUrl}) async {
    final usersData = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // final User? user = auth.currentUser;
    final uid = usersData?.uid;
    try {
      await users.doc(uid).set({
        userName: fullName,
        userEmail: email,
        userPassword: password,
        userPhoto: photoUrl
      });
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  static Future<String?> getUser() async {
    print('started  calling the firebase ');
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final auth = FirebaseAuth.instance;

    try {
      final uid = auth.currentUser!.uid;
      final snapshot = await users.doc(uid).get();

      userData.add(snapshot[userName]);
      userData.add(snapshot[userPhoto]);
      userData.add(snapshot[userEmail]);
      userData.add(snapshot[userPassword] ?? 'password');
      if (userData.isNotEmpty) {
        return 'successfully fetched userData';
      }
      // final User? user = auth.currentUser;
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  static Future<String> updateUserData(String key, String value) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({key: value});
      return 'Successfully updated';
    } catch (e) {
      return 'some trouble affeting uploading time ';
    }
  }

  static Future<Null> addUserLeaderboardInfo({
    required String score,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final uid = user?.uid;
    final snapshot = await users.doc(uid).get();
    String userScore = await FirebaseFirestoreData.getLeaderBoardScore();
    if (userScore.contains(RegExp(r'\d'))) {
      FirebaseFirestore.instance.collection('LeaderBoard').doc(uid).update({
        leaderBoardScore: score,
        userName: snapshot[userName] ?? '',
        userPhoto: snapshot[userPhoto]
      });
    } else {
      await FirebaseFirestore.instance.collection('LeaderBoard').doc(uid).set({
        leaderBoardScore: score,
        userName: snapshot[userName] ?? '',
        userPhoto: snapshot[userPhoto]
      });
    }
  }

  static Future<String> getLeaderBoardScore() async {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference leaderBoard =
        FirebaseFirestore.instance.collection('LeaderBoard');

    final uid = user?.uid;
    try {
      final snapshot = await leaderBoard.doc(uid).get();
      return snapshot[leaderBoardScore];
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getLeaderBoardData() async {
    // Get a reference to the collection
    // ignore: non_constant_identifier_names
    CollectionReference leaderBoard =
        FirebaseFirestore.instance.collection('LeaderBoard');

    // Get all documents in the collection
    QuerySnapshot querySnapshot = await leaderBoard.get();

    // Convert each document to a map and add it to a list
    List<Map<String, dynamic>> data = [];
    for (var doc in querySnapshot.docs) {
      data.add(doc.data() as Map<String, dynamic>);
    }

    // Return the list of maps
    return data;
  }
}
