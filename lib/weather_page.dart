import 'dart:convert';
import 'package:weather_app/main_forecast_card.dart';

import 'package:weather_app/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/additional_information_row.dart';
import 'package:weather_app/hourly_forecast_cards.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Multan";
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,pk&APPID=$openWeatherAPIKey",
        ),
      );
      final data = jsonDecode(res.body);
      if (data["cod"] != "200") {
        throw "An Unexpected Error Occured";
      }
      return data;
      // data["list"][0]["main"]["temp"];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    weather = getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, size: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
            iconSize: 30,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          // print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: LinearProgressIndicator(
                backgroundColor: Colors.blueAccent,
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;

          final currentWeatherData = data["list"][0];
          final currentTemp =
              (currentWeatherData["main"]["temp"] - 273).toStringAsFixed(0);
          final minTemp =
              (currentWeatherData["main"]["temp_min"] - 273).toStringAsFixed(0);
          final maxTemp =
              (currentWeatherData["main"]["temp_max"] - 273).toStringAsFixed(0);
          final feelsLikeTempratue =
              (currentWeatherData["main"]["feels_like"] - 273)
                  .toStringAsFixed(0);
          final currentSky = currentWeatherData["weather"][0]["main"];
          final currentPressure = currentWeatherData["main"]["pressure"];
          final currentHumidity = currentWeatherData["main"]["humidity"];
          final double currentWindSpeed = currentWeatherData["wind"]["speed"];

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Main Card
                  SizedBox(
                    width: double.infinity,
                    child: MainForecastCard(
                      cityNameMainForecastCard: "Multan",
                      dateTime: "Sat, 31 August",
                      iconWeather: currentSky == "Clouds"
                          ? WeatherIcons.cloudy
                          : currentSky == "Rain"
                              ? WeatherIcons.rain
                              : currentSky == "Wind"
                                  ? Icons.air
                                  : WeatherIcons.day_sunny,
                      currentTemprature: "$currentTemp°C",
                      currentSky: currentSky,
                      minMaxTemprature: "$minTemp°/$maxTemp°",
                      feelsLike: feelsLikeTempratue,
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Card(
                        elevation: 0,
                        color: Color.fromARGB(255, 58, 161, 230),
                        child: Text(
                          "Updated 31/08 18:15",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Forecast Card
                  const Text(
                    "Forecast",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 168,
                    child: ListView.builder(
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data["list"][index + 1];
                          final hourlyDateTime =
                              DateTime.parse(hourlyForecast["dt_txt"]);
                          return HourlyForecastCard(
                            time: DateFormat.Hm().format(hourlyDateTime),
                            tempratue: ((hourlyForecast["main"]["temp"] - 273))
                                .toStringAsFixed(0),
                            icon: (hourlyForecast["weather"][0]["main"]) ==
                                    "Clouds"
                                ? WeatherIcons.cloudy
                                : currentSky == "Rain"
                                    ? WeatherIcons.rain
                                    : currentSky == "Wind"
                                        ? Icons.air
                                        : WeatherIcons.day_sunny,
                            rainPreciption:
                                ((hourlyForecast["main"]["humidity"]) as int)
                                    .toString(),
                          );
                        }),
                  ),
                  //Additional Information
                  const SizedBox(height: 20),
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInformationRow(
                          informationIcon: Icons.water_drop,
                          informationName: "Humidity",
                          informationReading: currentHumidity.toString(),
                          informationUnit: "%",
                        ),
                        AdditionalInformationRow(
                          informationIcon: Icons.air,
                          informationName: "Wind",
                          informationReading:
                              currentWindSpeed.toStringAsFixed(0),
                          informationUnit: "Km/H",
                        ),
                        AdditionalInformationRow(
                          informationIcon: Icons.beach_access,
                          informationName: "Pressure",
                          informationReading: currentPressure.toString(),
                          informationUnit: "hPa",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
