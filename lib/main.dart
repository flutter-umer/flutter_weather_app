import 'package:flutter/material.dart';
import 'package:weather_app/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 58, 161, 230),
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 58, 161, 230)),
      ),
      debugShowCheckedModeBanner: false,
      home: const WeatherPage(),
    );
  }
}
