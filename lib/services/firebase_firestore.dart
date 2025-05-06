import 'package:quiz_app/utilities/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreData {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get _currentUser => FirebaseAuth.instance.currentUser;
  static Future<String?> addUser(
      String fullName, String email, String password, String photoUrl) async {
    if (_currentUser == null) {
      return 'No authenticated user found';
    }

    try {
      await _firestore.collection('users').doc(_currentUser!.uid).set({
        FirebaseKeys.userName: fullName,
        FirebaseKeys.userEmail: email,
        FirebaseKeys.userPassword: password,
        FirebaseKeys.userPhoto: photoUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return 'User data saved successfully';
    } catch (e) {
      return 'Error adding user: ${e.toString()}';
    }
  }

  static Future<Map<String, dynamic>> getUser() async {
    if (_currentUser == null) {
      return {'error': 'No authenticated user found'};
    }

    try {
      final snapshot =
          await _firestore.collection('users').doc(_currentUser!.uid).get();
      if (!snapshot.exists) {
        return {'error': 'no user data found'};
      }
      return snapshot.data() ?? {'error': 'No data available'};

      // final User? user = auth.currentUser;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<String> updateUserData(String key, String value) async {
    if (_currentUser == null) {
      return 'No authenticated user found';
    }

    try {
      await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .update({key: value});
      return 'Data updated successfully';
    } catch (e) {
      return 'Error updating data: ${e.toString()}';
    }
  }

  static Future<String> updateLeaderboardScore({
    required String score,
  }) async {
    if (_currentUser == null) {
      return 'No authenticated user found';
    }
    try {
      final userSnapshot =
          await _firestore.collection('users').doc(_currentUser!.uid).get();
      if (!userSnapshot.exists) {
        return 'User data not found';
      }
      // Get current leaderboard data
      final leaderboardRef =
          _firestore.collection('LeaderBoard').doc(_currentUser!.uid);
      final leaderboardSnapshot = await leaderboardRef.get();
      // Extract user data for leaderboard
      final userData = userSnapshot.data() ?? {};
      final leaderboardData = {
        FirebaseKeys.userScore: score,
        FirebaseKeys.userName: userData[FirebaseKeys.userName] ?? 'Unknown',
        FirebaseKeys.userPhoto: userData[FirebaseKeys.userPhoto] ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (leaderboardSnapshot.exists) {
        await leaderboardRef.update(leaderboardData);
        return 'Leaderboard score updated';
      } else {
        await leaderboardRef.set(leaderboardData);
        return 'Added to leaderboard';
      }
    } catch (e) {
      return 'Error updating leaderboard: ${e.toString()}';
    }
  }

  static Future<String> getLeaderBoardScore() async {
    if (_currentUser == null) {
      return '0';
    }
    try {
      final docSnapshot = await _firestore
          .collection('LeaderBoard')
          .doc(_currentUser!.uid)
          .get();
      if (docSnapshot.exists &&
          docSnapshot.data()!.containsKey(FirebaseKeys.userScore)) {
        return docSnapshot.data()![FirebaseKeys.userScore];
      }
    } catch (e) {
      return e.toString();
    }
    return '0';
  }

  static Future<List<Map<String, dynamic>>> getLeaderBoardData() async {
    try {
      List<Map<String, dynamic>> leaderboardData = [];
      final querySnapshot = await _firestore
          .collection("LeaderBoard")
          .orderBy(FirebaseKeys.userScore, descending: true)
          .limit(50) // Limit to top 100 scores for performance
          .get();
      for (var doc in querySnapshot.docs) {
        leaderboardData.add(doc.data());
      }
      return leaderboardData;
    } catch (e) {
      return [];
    }
  }
}
