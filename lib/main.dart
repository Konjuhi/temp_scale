import 'package:flutter/material.dart';
import 'package:temp_scale/screens/office_grid_screen.dart';
import 'dart:math';
import 'models/office.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Office Temperature Control',
      home: OfficeGridPage(
        offices: [
          ...generateOfficesForFloor('1', 12, 1),
          ...generateOfficesForFloor('2', 12, 13),
          ...generateOfficesForFloor('3', 12, 25),
        ],
      ),
    );
  }
}

List<Office> generateOfficesForFloor(String floor, int count, int startNumber) {
  Random random = Random();
  List<double> predefinedHeatingSets = [8.99, 21.99, 24.0, 25.42, 28.0, 22.0];

  return List.generate(count, (index) {
    double heatingSet =
        predefinedHeatingSets[random.nextInt(predefinedHeatingSets.length)];
    double temperature = 15 + random.nextDouble() * 10;
    return Office(
      floor: floor,
      officeNumber: '${startNumber + index}',
      temperature: double.parse(temperature.toStringAsFixed(2)),
      heatingSet: heatingSet,
    );
  });
}
