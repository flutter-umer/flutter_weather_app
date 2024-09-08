import 'package:flutter/material.dart';

class AdditionalInformationRow extends StatelessWidget {
  final IconData informationIcon;
  final String informationName;
  final String informationReading;
  final String informationUnit;
  const AdditionalInformationRow({
    super.key,
    required this.informationIcon,
    required this.informationName,
    required this.informationReading,
    required this.informationUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color.fromARGB(255, 58, 161, 230),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Icon(
              informationIcon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 4),
            Text(
              informationName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$informationReading $informationUnit ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
