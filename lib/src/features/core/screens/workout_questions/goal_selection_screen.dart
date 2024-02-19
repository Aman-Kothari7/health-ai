import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/core/screens/workout_questions/days_per_week_selection_screen.dart';

// Import your next screen here if you have one

class GoalSelectionScreen extends StatefulWidget {
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String _selectedGoal = 'Gain Muscle'; // Default fitness goal

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
          'Select Your Goal',
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
            value: 4 / 6, // Adjust based on your actual progress value
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What is your goal?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Select the option that best describes your fitness goal.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                _goalOption('Gain Muscle', Icons.fitness_center),
                SizedBox(height: 48),
                _goalOption('Increase Agility', Icons.directions_run),
                SizedBox(height: 48),
                _goalOption('Increase Endurance', Icons.timer),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                // Implement navigation to the next screen or action
                Get.to(() => DaysPerWeekSelectionScreen());
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

  Widget _goalOption(String goal, IconData icon) {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _selectedGoal = goal;
        });
      },
      label: Text(
        goal,
        style: TextStyle(
          fontSize: 16.0,
          color: _selectedGoal == goal ? Colors.white : Colors.black,
        ),
      ),
      icon: Icon(
        icon,
        color: _selectedGoal == goal ? Colors.white : Colors.black,
      ),
      backgroundColor: _selectedGoal == goal ? Colors.blue : Colors.grey[200],
      heroTag: null, // Important when having multiple floating action buttons
    );
  }
}