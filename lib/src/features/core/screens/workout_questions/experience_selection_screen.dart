import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/core/screens/workout_questions/training_style_selection_screen.dart';
// Import the next screen if you have one already defined

class ExperienceSelectionScreen extends StatefulWidget {
  @override
  _ExperienceSelectionScreenState createState() => _ExperienceSelectionScreenState();
}

class _ExperienceSelectionScreenState extends State<ExperienceSelectionScreen> {
  String _selectedExperience = 'Beginner'; // Default or initial experience level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Use GetX navigation method to go back
          },
        ),
        title: Text(
          'Select Experience Level',
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
            value: 2 / 6, // Adjust based on your actual progress value
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What\'s your experience level?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Select the option that best describes you.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                _experienceOption('Beginner', Icons.star_border),
                SizedBox(height: 48),
                _experienceOption('Intermediate', Icons.star_half),
                SizedBox(height: 48),
                _experienceOption('Advanced', Icons.star),
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
                // Implement the navigation to the next screen
                Get.to(() => TrainingStyleSelectionScreen());
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

  Widget _experienceOption(String level, IconData icon) {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _selectedExperience = level;
        });
      },
      label: Text(
        level,
        style: TextStyle(
          fontSize: 16.0,
          color: _selectedExperience == level ? Colors.white : Colors.black,
        ),
      ),
      icon: Icon(
        icon,
        color: _selectedExperience == level ? Colors.white : Colors.black,
      ),
      backgroundColor: _selectedExperience == level ? Colors.blue : Colors.grey[200],
      heroTag: null, // Important when having multiple floating action buttons
    );
  }
}