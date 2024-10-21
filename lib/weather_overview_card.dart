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
}