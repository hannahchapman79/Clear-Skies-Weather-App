import 'package:clearskies/weather_overview_card.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> { 
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather([String? city]) async {
    String? apiKey = dotenv.env['WEATHER_API_KEY'];
    city ??= "London";

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  Map<String, String> convertDate(Map<String, dynamic> weatherData) {
    int timezoneShiftInSeconds = weatherData["timezone"];
    int timestamp = weatherData["dt"];

    DateTime utcTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    Duration timezoneOffset = Duration(seconds: timezoneShiftInSeconds);
    DateTime localTime = utcTime.add(timezoneOffset);

    String formattedDate = DateFormat('EEE d').format(localTime);
    String daySuffix = getDayOfMonthSuffix(localTime.day); 
    String formattedMonth = DateFormat('MMMM').format(localTime);

    String formattedTime = DateFormat('HH:mm').format(localTime);

    return {
      "date": '$formattedDate$daySuffix $formattedMonth',
      "time": formattedTime,
    };
  }

  String getDayOfMonthSuffix(int day) {
    if (!(day >= 1 && day <= 31)) {
      throw Exception('Invalid day of month');
    }
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    if (weatherData == null) {
      return const Scaffold(
        body: Center(child: Text('Error loading weather data')),
      );
    }

    Map<String, String> dateTime = convertDate(weatherData!);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Clear Skies Weather App'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height *
                  0.4, 
              decoration: BoxDecoration(
                color: () {
                  String icon = weatherData!["weather"][0]["icon"];
                  if (icon.endsWith("n")) {
                    return const Color.fromRGBO(
                        128, 49, 255, 1); // Purple for night
                  } else if (icon == "01d") {
                    return const Color.fromRGBO(
                        255, 174, 0, 1); // Yellow for clear day
                  } else if (icon == "02d" || icon == "04d" || icon == "03d") {
                    return const Color.fromRGBO(
                        0, 122, 255, 1); // Blue for partly cloudy
                  } else {
                    return const Color.fromARGB(255, 117, 108, 179); // Default purple/grey
                  }
                }(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          Center(
            child: 
              Expanded(
                child: WeatherOverviewItem(
                  date: dateTime["date"]!,
                  time: dateTime["time"]!,
                  location: weatherData!["name"],
                  temperature: weatherData!["main"]["temp"].toInt(),
                  apiIconCode: weatherData!["weather"][0]["icon"],
                  description: weatherData!["weather"][0]["description"],
                  feelsLike: weatherData!["main"]["feels_like"].toInt(),
                  onCityChanged: (newCity) {
                    setState(() {
                      isLoading = true;
                    });
                    fetchWeather(newCity);
                  },
                ),
              ),
          ),
        ],
      ),
    );
  }
}
