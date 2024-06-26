import 'package:flutter/material.dart';
import '../models/office.dart';
import '../widgets/office_card.dart';

class OfficeGridPage extends StatefulWidget {
  final List<Office> offices;

  const OfficeGridPage({super.key, required this.offices});

  @override
  OfficeGridPageState createState() => OfficeGridPageState();
}

class OfficeGridPageState extends State<OfficeGridPage> {
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
            crossAxisSpacing: 4.0, // Reduced spacing
            mainAxisSpacing: 4.0, // Reduced spacing
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
      // Desktop
      return 8;
    } else if (screenWidth >= 600) {
      // Tablet
      return 4;
    } else {
      // Mobile
      return 2;
    }
  }
}
