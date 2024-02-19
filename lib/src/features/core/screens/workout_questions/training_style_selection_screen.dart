import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/core/screens/workout_questions/goal_selection_screen.dart';
// Import your next screen here if you have one

class TrainingStyleSelectionScreen extends StatefulWidget {
  @override
  _TrainingStyleSelectionScreenState createState() => _TrainingStyleSelectionScreenState();
}

class _TrainingStyleSelectionScreenState extends State<TrainingStyleSelectionScreen> {
  String _selectedTrainingStyle = 'Weight Training'; // Default training style

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
          'Select Training Style',
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
            value: 3 / 6, // Adjust based on your actual progress value
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pick a training style?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Select the option that best describes your preference.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                _trainingStyleOption('Weight Training', Icons.fitness_center),
                SizedBox(height: 48),
                _trainingStyleOption('Calisthenics', Icons.accessibility_new),
                SizedBox(height: 48),
                _trainingStyleOption('Functional Training', Icons.directions_run),
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
                Get.to(() => GoalSelectionScreen());
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

  Widget _trainingStyleOption(String trainingStyle, IconData icon) {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _selectedTrainingStyle = trainingStyle;
        });
      },
      label: Text(
        trainingStyle,
        style: TextStyle(
          fontSize: 16.0,
          color: _selectedTrainingStyle == trainingStyle ? Colors.white : Colors.black,
        ),
      ),
      icon: Icon(
        icon,
        color: _selectedTrainingStyle == trainingStyle ? Colors.white : Colors.black,
      ),
      backgroundColor: _selectedTrainingStyle == trainingStyle ? Colors.blue : Colors.grey[200],
      heroTag: null, // Important when having multiple floating action buttons
    );
  }
}