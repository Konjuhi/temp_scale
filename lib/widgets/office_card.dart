import 'package:flutter/material.dart';

import '../models/office.dart';
import 'office_detail.dart';

class OfficeCard extends StatelessWidget {
  final Office office;
  final VoidCallback onTap;

  const OfficeCard({super.key, required this.office, required this.onTap});

  Color _getBackgroundColor(double heatingSet) {
    if (heatingSet <= 8.99) {
      return Colors.grey;
    } else if (heatingSet > 8.99 && heatingSet <= 21.99) {
      return Colors.green;
    } else if (heatingSet >= 24) {
      return Colors.brown;
    }
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: InkSplash.splashFactory,
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Card(
          color: _getBackgroundColor(office.heatingSet),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Office ${office.officeNumber}',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  '${office.temperature}°C',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Heating set to ${office.heatingSet}°',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfficeDashboardScreen extends StatefulWidget {
  final List<Office> offices;

  const OfficeDashboardScreen({super.key, required this.offices});

  @override
  OfficeDashboardScreenState createState() => OfficeDashboardScreenState();
}

class OfficeDashboardScreenState extends State<OfficeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          buildFloor(widget.offices.where((o) => o.floor == '1').toList(),
              'Floor 1', context),
          buildFloor(widget.offices.where((o) => o.floor == '2').toList(),
              'Floor 2', context),
          buildFloor(widget.offices.where((o) => o.floor == '3').toList(),
              'Floor 3', context),
        ],
      ),
    );
  }

  Widget buildFloor(
      List<Office> floorOffices, String floorName, BuildContext context) {
    int crossAxisCount = getCrossAxisCount(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              floorName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        const Divider(),
        GridView.builder(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.2, // Maintaining a consistent aspect ratio
          ),
          itemCount: floorOffices.length,
          itemBuilder: (context, index) {
            return OfficeCard(
              office: floorOffices[index],
              onTap: () => showOfficeDetails(context, floorOffices[index],
                  (updatedOffice) {
                setState(() {
                  int officeIndex = widget.offices.indexWhere((o) =>
                      o.officeNumber == updatedOffice.officeNumber &&
                      o.floor == updatedOffice.floor);
                  if (officeIndex != -1) {
                    widget.offices[officeIndex] = updatedOffice;
                  }
                });
              }),
            );
          },
        ),
      ],
    );
  }

  int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) {
      return 8;
    } else if (screenWidth >= 600) {
      return 4;
    } else {
      return 2;
    }
  }
}

void showOfficeDetails(
    BuildContext context, Office office, Function(Office) onSave) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return OfficeDetailsDialog(office: office, onSave: onSave);
    },
  );
}
