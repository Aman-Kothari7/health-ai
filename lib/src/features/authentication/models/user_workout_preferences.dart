import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';

class UserWorkoutPreferences {
  final String UID;
  final String workoutLocation;
  final String workoutExperienceLevel;
  final String workoutTrainingStyle;
  final String workoutGoal;
  final int workoutDaysPerWeek;
  final int workoutDuration;
  final String WID;

  UserWorkoutPreferences({
    required this.UID,
    required this.workoutLocation,
    required this.workoutExperienceLevel,
    required this.workoutTrainingStyle,
    required this.workoutGoal,
    required this.workoutDaysPerWeek,
    required this.workoutDuration,
    required this.WID,
  });

  factory UserWorkoutPreferences.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserWorkoutPreferences(
      UID: data['UID'] as String? ?? '',
      workoutLocation: data['workoutLocation'] as String? ?? ' ',
      workoutExperienceLevel: data['workoutExperienceLevel'] as String? ?? ' ',
      workoutTrainingStyle: data['workoutTrainingStyle'] as String? ?? ' ',
      workoutGoal: data['workoutGoal'] as String? ?? ' ',
      workoutDaysPerWeek: data['workoutDaysPerWeek'] as int? ?? 0,
      workoutDuration: data['workoutDuration'] as int? ?? 0,
      WID: data['WID'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'UID': AuthenticationRepository.instance.getUserID,
        'workoutLocation': workoutLocation,
        'workoutExperienceLevel': workoutExperienceLevel,
        'workoutTrainingStyle': workoutTrainingStyle,
        'workoutGoal': workoutGoal,
        'workoutDaysPerWeek': workoutDaysPerWeek,
        'workoutDuration': workoutDuration,
        'WID': WID,
      };
}
