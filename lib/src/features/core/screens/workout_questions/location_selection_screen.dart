import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/initial_settings_controller.dart';
import 'package:login_flutter_app/src/features/core/screens/workout_questions/experience_selection_screen.dart';

// //import 'your_next_screen_path.dart'; // Replace with your actual import for the next screen

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String _selectedLocation = 'Home'; // Default or initial location
  final InitialSettingsController settingsController =
      Get.put(InitialSettingsController());

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
          'Select Training Location',
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
            value: 1 / 6, // Adjust based on your actual progress value
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Where would you like to train?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This helps us tailor your workout plan',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 50),
                Container(
                  height: 400,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _selectedLocation = 'Home';
                            });
                          },
                          backgroundColor: _selectedLocation == 'Home'
                              ? Colors.blue
                              : Colors.grey[200],
                          heroTag: 'home',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home,
                                  size: 70,
                                  color: _selectedLocation == 'Home'
                                      ? Colors.white
                                      : Colors.black),
                              Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _selectedLocation == 'Home'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _selectedLocation = 'Gym';
                            });
                          },
                          backgroundColor: _selectedLocation == 'Gym'
                              ? Colors.blue
                              : Colors.grey[200],
                          heroTag: 'gym',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.fitness_center,
                                  size: 70,
                                  color: _selectedLocation == 'Gym'
                                      ? Colors.white
                                      : Colors.black),
                              Text(
                                'Gym',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _selectedLocation == 'Gym'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                settingsController.saveWorkoutLocation(_selectedLocation);
                Get.to(() => ExperienceSelectionScreen());
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
}
