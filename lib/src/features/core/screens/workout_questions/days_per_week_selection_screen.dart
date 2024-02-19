import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/core/screens/workout_questions/workout_duration_selection_screen.dart';
// Import your next screen here if you have one

class DaysPerWeekSelectionScreen extends StatefulWidget {
  @override
  _DaysPerWeekSelectionScreenState createState() => _DaysPerWeekSelectionScreenState();
}

class _DaysPerWeekSelectionScreenState extends State<DaysPerWeekSelectionScreen> {
  int _selectedDays = 3; // Default number of days

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
          'Workout Days',
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
            value: 5 / 6, // Adjust based on your actual progress value
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Workout frequency per week?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Select the number that fits your schedule.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                Wrap(
                  spacing: 20, // Horizontal space between buttons
                  runSpacing: 20, // Vertical space between buttons
                  children: List.generate(
                    4, // Generating 4 buttons for 3, 4, 5, 6 days
                    (index) => _dayOption(3 + index),
                  ),
                ),
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
                Get.to(() => WorkoutDurationSelectionScreen());
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

  Widget _dayOption(int days) {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _selectedDays = days;
        });
      },
      label: Text(
        '$days',
        style: TextStyle(
          fontSize: 16.0,
          color: _selectedDays == days ? Colors.white : Colors.black,
        ),
      ),
      icon: Icon(
        Icons.calendar_today,
        color: _selectedDays == days ? Colors.white : Colors.black,
      ),
      backgroundColor: _selectedDays == days ? Colors.blue : Colors.grey[200],
      heroTag: null, // Important when having multiple floating action buttons
    );
  }
}