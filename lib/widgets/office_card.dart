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
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 200, height: 150),
        child: Card(
          color: _getBackgroundColor(office.heatingSet),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'Office ${office.officeNumber}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    '${office.temperature}°C',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    'Heating set to ${office.heatingSet}°',
                  overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
