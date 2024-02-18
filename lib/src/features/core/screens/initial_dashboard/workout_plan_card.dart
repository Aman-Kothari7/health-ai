import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';

class WorkoutPlanCard extends StatelessWidget {
  final Function() onCardTap;

  const WorkoutPlanCard({Key? key, required this.onCardTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(initialDashMargin),
      // Card configuration
      child: InkWell(
        onTap: onCardTap,
        // Rest of the InkWell and Card configuration
        child: Padding(
          padding: EdgeInsets.all(initialDashCardPadding * 2),
          child: Center(
            child: Text(
              'Create Workout Plan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
