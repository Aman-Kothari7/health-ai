import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login_flutter_app/src/repository/user_repository/user_repository.dart';

class WorkoutDashboardScreen extends StatefulWidget {
  const WorkoutDashboardScreen({Key? key}) : super(key: key);

  @override
  _WorkoutDashboardScreenState createState() => _WorkoutDashboardScreenState();
}

class _WorkoutDashboardScreenState extends State<WorkoutDashboardScreen> {
  UserRepository _userRepository = UserRepository();
  String userId = AuthenticationRepository.instance.getUserID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Workout Plan"),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userRepository.fetchUserWorkoutPlan(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data == null) {
            return const Center(child: Text("No workout plan found."));
          }

          var workoutPlan =
              snapshot.data!['workout_plan'] as Map<String, dynamic>;
          var days = workoutPlan.keys.toList()..sort();

          return ListView.builder(
            itemCount: days.length,
            itemBuilder: (context, index) {
              var day = days[index];
              var dayPlan = workoutPlan[day];
              var exercises = dayPlan['exercises'] as List<dynamic>;

              return ExpansionTile(
                title: Text(day.replaceAll('_', ' ').toUpperCase()),
                subtitle: Text(dayPlan['target_muscle_group']),
                children: exercises.map<Widget>((exercise) {
                  return ListTile(
                    title: Text(exercise['name']),
                    subtitle: Text(
                        "Sets: ${exercise['no_of_sets']}, Reps: ${exercise['reps_per_set']}"),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
