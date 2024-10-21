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
}