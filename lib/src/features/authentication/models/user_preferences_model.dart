import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  final int age;
  final String weightGoal;
  final double weight;
  final String gender;
  final String activityLevel;
  final int heightCM;

  UserPreferences({
    required this.age,
    required this.weightGoal,
    required this.weight,
    required this.gender,
    required this.activityLevel,
    required this.heightCM,
  });

  factory UserPreferences.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserPreferences(
      age: data['age'] as int? ?? 0,
      weightGoal: data['weightGoal'] as String? ?? '',
      weight: data['weight'] as double? ?? 0.0,
      gender: data['gender'] as String? ?? '',
      activityLevel: data['activityLevel'] as String? ?? '',
      heightCM: data['heightCM'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'age': age,
    'weightGoal': weightGoal,
    'weight': weight,
    'gender': gender,
    'activityLevel': activityLevel,
    'heightCM': heightCM,
  };

  
}
