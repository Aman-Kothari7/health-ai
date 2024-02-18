import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';

class userInfoCard extends StatelessWidget {
  const userInfoCard({
    super.key,
    required this.age,
    required this.heightDisplay,
    required this.weightDisplay,
    required this.bmi,
  });

  final int? age;
  final String? heightDisplay;
  final String weightDisplay;
  final String? bmi;

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 4,
      margin: EdgeInsets.all(initialDashMargin),
      child: Padding(
        padding: EdgeInsets.all(initialDashCardPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('AGE\n$age'),
            Text('HEIGHT\n$heightDisplay'),
            Text('WEIGHT\n$weightDisplay'),
            Text('BMI\n$bmi'),
          ],
        ),
      ),
    );
  }
}
