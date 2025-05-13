import 'package:flutter/material.dart';

import '../models/dashboardcards.dart';

class DashboardCard extends StatelessWidget {
  final DashboardCardData cardData;

  const DashboardCard({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: cardData.color, // Use the color from the data model
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center content
          children: <Widget>[
            Icon(
              cardData.icon,
              size: 30,
              color: Colors.white, // Ensure icon is visible on colored background
            ),
            const SizedBox(height: 10),
            Text(
              cardData.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center, // Center the text
            ),
            const SizedBox(height: 5),
            Text(
              cardData.count.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
