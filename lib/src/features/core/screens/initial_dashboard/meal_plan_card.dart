import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';

class MealPlanCard extends StatelessWidget {
  final Function() onCardTap;

  const MealPlanCard({Key? key, required this.onCardTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card configuration
      margin: EdgeInsets.all(initialDashMargin),
      child: InkWell(
        onTap: onCardTap,
        // Rest of the InkWell and Card configuration
        child: Padding(
          padding: EdgeInsets.all(initialDashCardPadding * 2),
          child: Center(
            child: Text(
              'Create Meal Plan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
