import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String rainPreciption;
  final String tempratue;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.tempratue,
    required this.icon,
    required this.rainPreciption,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(27),
      child: Card(
        elevation: 6,
        color: const Color.fromARGB(157, 146, 212, 255),
        child: Container(
          width: 95,
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 8),
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                "$rainPreciption%",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "$tempratue°",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
