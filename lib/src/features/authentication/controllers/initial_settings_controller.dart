import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_preferences_model.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_workout_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialSettingsController extends GetxController {
  static InitialSettingsController get instance => Get.find();

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveAge(int age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', age);
  }

  Future<void> saveWeightGoal(String weightGoal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('weightGoal', weightGoal);
  }

  Future<void> saveWeight(double weight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', weight);
  }

  Future<void> saveGender(String gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', gender);
  }

  Future<void> saveActivityLevel(String activityLevel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activityLevel', activityLevel);
  }

  Future<void> saveHeightCM(int heightCM) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('heightCM', heightCM);
  }

  Future<void> saveHeightInches(int heightInches) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('heightInches', heightInches);
  }

  Future<void> saveIsCM(bool isCM) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCM', isCM);
  }

  Future<void> saveIsKg(bool isKg) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isKg', isKg);
  }

  Future<UserPreferences> getUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return UserPreferences(
      age: prefs.getInt('age') ?? 0,
      weightGoal: prefs.getString('weightGoal') ?? '',
      weight: prefs.getDouble('weight') ?? 0.0,
      gender: prefs.getString('gender') ?? '',
      activityLevel: prefs.getString('activityLevel') ?? '',
      heightCM: prefs.getInt('heightCM') ?? 0,
      UID: '',
    );
  }

  Future<void> saveWorkoutLocation(String workoutLocation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workoutLocation', workoutLocation);
  }

  Future<void> saveWorkoutExperienceLevel(String workoutExperienceLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workoutExperienceLevel', workoutExperienceLevel);
  }

  Future<void> saveWorkoutTrainingStyle(String workoutTrainingStyle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workoutTrainingStyle', workoutTrainingStyle);
  }

  Future<void> saveWorkoutGoal(String workoutGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workoutGoal', workoutGoal);
  }

  Future<void> saveWorkoutDaysPerWeek(int workoutDaysPerWeek) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('workoutDaysPerWeek', workoutDaysPerWeek);
  }

  Future<void> saveWorkoutDuration(int workoutDuration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('workoutDuration', workoutDuration);
  }

  Future<UserWorkoutPreferences> getWorkoutUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return UserWorkoutPreferences(
      UID: '',
      workoutLocation: prefs.getString('workoutLocation') ?? '',
      workoutExperienceLevel: prefs.getString('workoutExperienceLevel') ?? '',
      workoutTrainingStyle: prefs.getString('workoutTrainingStyle') ?? '',
      workoutGoal: prefs.getString('workoutGoal') ?? '',
      workoutDaysPerWeek: prefs.getInt('workoutDaysPerWeek') ?? 0,
      workoutDuration: prefs.getInt('workoutDuration') ?? 0, WID: '',
    );
  }
}
