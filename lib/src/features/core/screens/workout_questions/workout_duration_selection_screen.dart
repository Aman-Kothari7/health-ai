import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/workout_dashboard.dart';
import 'package:login_flutter_app/src/repository/user_repository/user_repository.dart';
// Import the next screen or the home screen if this is the last selection screen

class WorkoutDurationSelectionScreen extends StatefulWidget {
  @override
  _WorkoutDurationSelectionScreenState createState() =>
      _WorkoutDurationSelectionScreenState();
}

class _WorkoutDurationSelectionScreenState
    extends State<WorkoutDurationSelectionScreen> {
  int _selectedDuration = 30; // Default workout duration
  final InitialSettingsController settingsController =
      Get.find<InitialSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Select Workout Duration',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinearProgressIndicator(
            value: 6 / 6, // Adjust based on your actual progress value
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How many mins per workout?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Select the duration that suits your schedule.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                _durationOption(30),
                SizedBox(height: 24),
                _durationOption(45),
                SizedBox(height: 24),
                _durationOption(60),
                SizedBox(height: 24),
                _durationOption(90),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                settingsController.saveWorkoutDuration(_selectedDuration);
                final initialSettingsController = InitialSettingsController();
                final preferences =
                    await initialSettingsController.getWorkoutUserPreferences();
                await UserRepository.instance.storeUserWorkoutPreferences(preferences);
                Get.to(() => const WorkoutDashboardScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _durationOption(int duration) {
    IconData iconData;
    switch (duration) {
      case 30:
        iconData = Icons
            .timer; // For simplicity, using the same icon with different tags
        break;
      case 45:
        iconData = Icons.timer;
        break;
      case 60:
        iconData = Icons.timer;
        break;
      case 90:
        iconData = Icons.timer;
        break;
      default:
        iconData = Icons.timer;
    }
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _selectedDuration = duration;
        });
      },
      label: Text(
        "$duration mins",
        style: TextStyle(
          fontSize: 16.0,
          color: _selectedDuration == duration ? Colors.white : Colors.black,
        ),
      ),
      icon: Icon(
        iconData,
        color: _selectedDuration == duration ? Colors.white : Colors.black,
      ),
      backgroundColor:
          _selectedDuration == duration ? Colors.blue : Colors.grey[200],
      heroTag: "duration$duration", // Ensures unique hero tags
    );
  }
}
