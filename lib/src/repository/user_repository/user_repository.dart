import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_preferences_model.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_workout_preferences.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';
import '../authentication_repository/exceptions/t_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Store user data
  Future<void> createUser(UserModel user) async {
    try {
      // It is recommended to use Authentication Id as DocumentId of the Users Collection.
      // To store a new user you first have to authenticate and get uID (e.g: Check Authentication Repository)
      // Add user like this: await _db.collection("Users").doc(uID).set(user.toJson());
      await recordExist(user.email)
          ? throw "Record Already Exists"
          : await _db.collection("Users").add(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

//TODO: Add error checks and record exist check for user preferences

  Future<void> storeUserPreferences(UserPreferences preferences) async {
    final userId = AuthenticationRepository.instance.getUserID;
    print(userId);
    final userPreferencesCollection =
        FirebaseFirestore.instance.collection('user_preferences');

    //await userPreferencesCollection.doc(userId).set(preferences.toJson());
    await _db.collection("user_preferences").add(preferences.toJson());
  }

  //Print entire collection
  // var collection_ref = _db.collection('user_workout_preferences');
  // QuerySnapshot querySnapshot = await collection_ref.get();
  // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  // for (var document in allData) {
  //   print(document); // Prints the document data to the console
  // }

  Future<Map<String, dynamic>?> fetchUserWorkoutPlan(String userId) async {
    try {
      var document =
          await _db.collection('user_workout_plan_details').doc(userId).get();
      return document.exists ? document.data() : null;
    } catch (e) {
      print("Error fetching workout plan: $e");
      return null;
    }
  }

  Future<void> matchAndStoreWorkoutPlan(
      UserWorkoutPreferences userPreferences) async {
    final userId = AuthenticationRepository.instance.getUserID;
    print("User id in user preferences:");
    print(userId);

    QuerySnapshot workoutPreferencesForUser = await _db
        .collection('user_workout_preferences')
        .where("UID", isEqualTo: userId.trim())
        .get();

    print("Documents matching UID: ${workoutPreferencesForUser.docs.length}");

    if (workoutPreferencesForUser.docs.isNotEmpty) {
      print("Document found");
      print("workoutPreferencesForUser");
    } else {
      print("Empty");
    }

    var workoutPreferencesForUserDocument =
        workoutPreferencesForUser.docs.first;
    print(workoutPreferencesForUserDocument);

    String workoutLocationLower = userPreferences.workoutLocation.toLowerCase();
    String workoutExperienceLevelLower =
        userPreferences.workoutExperienceLevel.toLowerCase();
    String workoutTrainingStyleLower =
        userPreferences.workoutTrainingStyle.toLowerCase();
    String workoutGoalLower = userPreferences.workoutGoal.toLowerCase();
    int workoutDuration = userPreferences.workoutDuration;
    int workoutDaysPerWeek = userPreferences.workoutDaysPerWeek;

    // Step 2: Query the `workoutplans` collection
    QuerySnapshot workoutPlansSnapshot = await _db
        .collection('workoutplans')
        .where('days_per_week', isEqualTo: workoutDaysPerWeek)
        .where('location', isEqualTo: workoutLocationLower)
        .where('preference', isEqualTo: workoutTrainingStyleLower)
        .where('level', isEqualTo: workoutExperienceLevelLower)
        .where('goal', isEqualTo: workoutGoalLower)
        .where('time_per_workout', isEqualTo: workoutDuration)
        .get();

    var selectedWorkoutPlan = workoutPlansSnapshot.docs.first;
    print("Selected workout plan $selectedWorkoutPlan");

    var workoutID = selectedWorkoutPlan.get('workoutid');

    await _db
        .collection('user_workout_preferences')
        .doc(workoutPreferencesForUserDocument.id)
        .update({'WID': workoutID});

    var workoutPlanJson = selectedWorkoutPlan.get('response');

    addWorkoutPlanToUser(userId, workoutPlanJson);
  }

  // Function to save the workout plan details for a user
  Future<void> saveUserWorkoutPlan(
      String userId, Map<String, dynamic> workoutPlan) async {
    await _db.collection('user_workout_plan_details').doc(userId).set({
      'workout_plan': workoutPlan,
      'userId': userId, 
    });
  }

  // Example function that decodes a workout plan from a JSON string and saves it
  Future<void> addWorkoutPlanToUser(
      String userId, String workoutPlanJson) async {
    // Decoding the JSON string into a Dart object
    Map<String, dynamic> workoutPlan = json.decode(workoutPlanJson);

    // Calling the function to save the workout plan to Firestore
    await saveUserWorkoutPlan(userId, workoutPlan['workout_plan']);
  }

  Future<void> storeUserWorkoutPreferences(
      UserWorkoutPreferences preferences) async {
    final userId = AuthenticationRepository.instance.getUserID;
    print(userId);
    //await userPreferencesCollection.doc(userId).set(preferences.toJson());
    await _db.collection("user_workout_preferences").add(preferences.toJson());
    matchAndStoreWorkoutPlan(preferences);
  }

  /// Fetch User Specific details
  Future<UserModel> getUserDetails(String email) async {
    try {
      // It is recommended to use Authentication Id as DocumentId of the Users Collection.
      // Then when fetching the record you only have to get user authenticationID uID and query as follows.
      // final snapshot = await _db.collection("Users").doc(uID).get();

      final snapshot =
          await _db.collection("Users").where("Email", isEqualTo: email).get();
      if (snapshot.docs.isEmpty) throw 'No such user found';

      // Single will throw exception if there are two entries when result return.
      // In case of multiple entries use .first to pick the first one without exception.
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  /// Fetch All Users
  Future<List<UserModel>> allUsers() async {
    try {
      final snapshot = await _db.collection("Users").get();
      final users =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return users;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Update User details
  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Delete User Data
  Future<void> deleteUser(String id) async {
    try {
      await _db.collection("Users").doc(id).delete();
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Check if user exists with email or phoneNo
  Future<bool> recordExist(String email) async {
    try {
      final snapshot =
          await _db.collection("Users").where("Email", isEqualTo: email).get();
      return snapshot.docs.isEmpty ? false : true;
    } catch (e) {
      throw "Error fetching record.";
    }
  }
}
