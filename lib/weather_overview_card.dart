import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WeatherOverviewItem extends StatelessWidget {
  final String apiIconCode;
  final int temperature;
  final String description;
  final String date;
  final String location;
  final String time;
  final int feelsLike;
  final Function(String) onCityChanged;

  const WeatherOverviewItem(
      {super.key,
      required this.temperature,
      required this.apiIconCode,
      required this.description,
      required this.date,
      required this.time,
      required this.location,
      required this.onCityChanged,
      required this.feelsLike});

     Map<String, Map<String, dynamic>> _getWeatherIconColour() {
    return {
      "01d": {
        "icon": const Icon(CupertinoIcons.sun_max_fill,
            size: 150, color: Color.fromRGBO(255, 174, 0, 1)),
      },
      "01n": {
        "icon": const Icon(CupertinoIcons.moon_stars_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "02d": {
        "icon": const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.cloud_fill,
              size: 100,
              color: Color.fromARGB(255, 71, 184, 255),
            ),
            SizedBox(width: 8),
            Icon(
              CupertinoIcons.sun_max_fill,
              size: 100,
              color: Color.fromRGBO(255, 174, 0, 1),
            ),
          ],
        ),
      },
      "02n": {
        "icon": const Icon(CupertinoIcons.cloud_moon_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "03d": {
        "icon": const Icon(CupertinoIcons.cloud_fill,
            size: 150, color: Color.fromARGB(255, 71, 184, 255)),
      },
      "03n": {
        "icon": const Icon(CupertinoIcons.cloud_moon_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "04d": {
        "icon": const Icon(CupertinoIcons.cloud_fill,
            size: 150, color: Color.fromARGB(255, 71, 184, 255)),
      },
      "04n": {
        "icon": const Icon(CupertinoIcons.cloud_moon_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "09d": {
        "icon": const Icon(CupertinoIcons.cloud_drizzle_fill,
            size: 150, color: Color.fromARGB(255, 117, 108, 179)),
      },
      "09n": {
        "icon": const Icon(CupertinoIcons.cloud_moon_rain_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "10d": {
        "icon": const Icon(CupertinoIcons.cloud_rain_fill,
            size: 150, color: Color.fromARGB(255, 117, 108, 179)),
      },
      "10n": {
        "icon": const Icon(CupertinoIcons.cloud_moon_rain_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "11d": {
        "icon": const Icon(CupertinoIcons.cloud_bolt_fill,
            size: 150, color: Color.fromARGB(255, 117, 108, 179)),
      },
      "11n": {
        "icon": const Icon(CupertinoIcons.cloud_moon_bolt_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "13d": {
        "icon": const Icon(CupertinoIcons.cloud_snow_fill,
            size: 150, color: Color.fromARGB(255, 117, 108, 179)),
      },
      "13n": {
        "icon": const Icon(CupertinoIcons.cloud_snow_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1)),
      },
      "50d": {
        "icon": const Icon(
          CupertinoIcons.cloud_fog_fill,
          size: 150,
          color: Color.fromARGB(255, 117, 108, 179),
        ),
      },
      "50n": {
        "icon": const Icon(CupertinoIcons.cloud_fog_fill,
            size: 150, color: Color.fromRGBO(128, 49, 255, 1))
      },
    };
  }
}