import 'package:flutter/material.dart';
import '../models/office.dart';

class OfficeDetailsDialog extends StatefulWidget {
  final Office office;
  final Function(Office) onSave;

  const OfficeDetailsDialog(
      {super.key, required this.office, required this.onSave});

  @override
  OfficeDetailsDialogState createState() => OfficeDetailsDialogState();
}

class OfficeDetailsDialogState extends State<OfficeDetailsDialog> {
  late double heatingSet;

  @override
  void initState() {
    super.initState();
    heatingSet = widget.office.heatingSet;
  }

  Color getBackgroundColor(double heatingSet) {
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
    return AlertDialog(
      backgroundColor: getBackgroundColor(heatingSet),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Office ${widget.office.officeNumber}',
            style: const TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '${widget.office.temperature}°C',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Heating set to ${heatingSet.toStringAsFixed(2)}°',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Slider(
            value: heatingSet,
            min: 0,
            max: 30,
            inactiveColor: Colors.white,
            activeColor: Colors.black,
            divisions: 100,
            label: heatingSet.toStringAsFixed(2),
            onChanged: (value) {
              setState(() {
                heatingSet = double.parse(value.toStringAsFixed(2));
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(widget.office
              ..heatingSet = double.parse(heatingSet.toStringAsFixed(2)));
            Navigator.of(context).pop();
          },
          child: const Text('Save', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
