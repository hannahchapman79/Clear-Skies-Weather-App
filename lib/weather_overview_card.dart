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

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> weatherIconMap = _getWeatherIconColour();

    final weatherData = weatherIconMap[apiIconCode] ??
        {"icon": const Icon(Icons.error), "color": Colors.blue.shade300};

    final weatherIcon = weatherData["icon"] as Widget;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container( 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.85),
                ],
              ),
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 36,
                        ),
                        SizedBox(
                          width: 220,
                          child: FocusScope(
                            child: TextField(
                              controller: TextEditingController(text: location),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              onSubmitted: onCityChanged,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    weatherIcon,
                    const SizedBox(height: 30),
                    Text(
                      '$temperature°',
                      style: const TextStyle(
                        fontSize: 88,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Feels like $feelsLike°",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
