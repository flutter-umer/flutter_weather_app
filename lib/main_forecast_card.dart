import 'dart:ui';

import 'package:flutter/material.dart';

class MainForecastCard extends StatelessWidget {
  final String cityNameMainForecastCard;
  final String dateTime;
  final IconData iconWeather;
  final String currentSky;
  final String currentTemprature;
  final String minMaxTemprature;
  final String feelsLike;

  const MainForecastCard({
    super.key,
    required this.cityNameMainForecastCard,
    required this.dateTime,
    required this.iconWeather,
    required this.currentTemprature,
    required this.currentSky,
    required this.minMaxTemprature,
    required this.feelsLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      color: const Color.fromARGB(255, 58, 161, 230),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  cityNameMainForecastCard,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                  child: Text(
                    dateTime,
                    style: const TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconWeather,
                      size: 58,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      currentTemprature,
                      style: const TextStyle(
                        fontSize: 75,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  currentSky,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "$minMaxTemprature Feels Like $feelsLike°",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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
