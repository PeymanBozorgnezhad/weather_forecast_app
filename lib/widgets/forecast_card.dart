import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/models/weather.dart';
import '../utils/forecast_util.dart';

Widget forecastCard(AsyncSnapshot<WeatherResponse> snapshot, int index) {
  var forecastList = snapshot.data;
  var dayOfWeek = "";
  var dayOfTime = "";
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList?.time ?? 0 * 1000);
  var fullDate = Util.getFormattedDate(date);
  dayOfWeek =
      fullDate.split(",")[0]; //[Tuesday, Dec 22, 2022, 12:00:AM] => Saturday
  dayOfTime = fullDate.split(",")[3];

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(child: Text(dayOfWeek + dayOfTime)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.white,
            child: Icon(
              forecastList?.getIconData(),
              size: 70,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                        "${(forecastList?.climateMeasurementInfo.temperature ?? 0.0 - 273.15).toStringAsFixed(0)}°C"),
                    const Icon(
                      FontAwesomeIcons.solidCircleDown,
                      color: Colors.white,
                      size: 17,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                        "${(forecastList?.climateMeasurementInfo.maxTemperature ?? 0.0 - 273.15).toStringAsFixed(0)}°C"),
                    const Icon(
                      FontAwesomeIcons.solidCircleUp,
                      color: Colors.white,
                      size: 17,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                        "Hum: ${(forecastList?.climateMeasurementInfo.humidity)?.toStringAsFixed(0)}%"),
                    const Icon(
                      FontAwesomeIcons.solidFaceGrinBeamSweat,
                      color: Colors.white,
                      size: 17,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                        "Win: ${(forecastList?.windInfo.windSpeed)?.toStringAsFixed(1)}mi/h"),
                    const Icon(
                      FontAwesomeIcons.solidFaceGrinBeamSweat,
                      color: Colors.white,
                      size: 17,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      )
    ],
  );
}
