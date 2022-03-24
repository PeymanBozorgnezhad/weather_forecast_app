/*
{
//in weather object into ro parse kardim hala when k mikhaim khoude value marbot b key weather ro return konim
//ba ye listi az objectha ro b ro hastim k bayad moshakhas konim kodom index ro mikhaym pars konim
  "weather": [
        {
            "id":800
            "description": "overcast clouds",
            "icon": "04d"
        }
    ],
  "main": {
        "temp": 282.14,
        "humidity": 100
    },
    "wind": {
        "speed": 1.03,
        "deg": 30
    },

  "name": "Babol",
}

*/

/*{
"temp": 282.14,
} */ //==>> object hast

import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_icon.dart';

class SysInfo {
  final int sunrise;
  final int sunset;

  SysInfo({required this.sunrise, required this.sunset});

  factory SysInfo.fromJson(Map<String, dynamic> json) {
    final sunrise = json['sunrise'];
    final sunset = json['sunset'];
    return SysInfo(sunrise: sunrise, sunset: sunset);
  }
}

class WindInfo {
  final double windSpeed;
  final int deg;

  WindInfo({required this.windSpeed, required this.deg});

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    final windSpeed = json['speed'];
    final deg = json['deg'];
    return WindInfo(windSpeed: windSpeed, deg: deg);
  }
}

class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String iconCode;

  WeatherInfo(
      {required this.id,
      required this.main,
      required this.description,
      required this.iconCode});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final main = json['main'];
    final description = json['description'];
    final iconCode = json['icon'];
    return WeatherInfo(
        id: id, main: main, description: description, iconCode: iconCode);
  }
}

class ClimateMeasurementInfo {
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;

  ClimateMeasurementInfo(
      {required this.temperature,
      required this.minTemperature,
      required this.maxTemperature,
      required this.humidity});

  factory ClimateMeasurementInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final minTemperature = json['temp_min'];
    final maxTemperature = json['temp_max'];
    final humidity = json['humidity'];
    return ClimateMeasurementInfo(
        temperature: temperature,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature,
        humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final int time;

  final ClimateMeasurementInfo climateMeasurementInfo;
  final WeatherInfo weatherInfo;
  final WindInfo windInfo;
  final SysInfo sysInfo;

  final List<WeatherResponse> forecast;

  WeatherResponse(
      {required this.time,
      required this.cityName,
      required this.climateMeasurementInfo,
      required this.weatherInfo,
      required this.windInfo,
      required this.sysInfo,
      required this.forecast});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final time = json['dt'];
    //todo ----------------MeasurementInfo------------------>
    final measurementInfoJson = json['main'];
    final measurementInfo =
        ClimateMeasurementInfo.fromJson(measurementInfoJson);
    //todo ----------------weatherInfo------------------>
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    //todo ----------------windInfo------------------>
    final windInfoJson = json['wind'];
    final windInfo = WindInfo.fromJson(windInfoJson);
    //todo ----------------sysInfo------------------>
    final sysInfoJson = json['sys'];
    final sysInfo = SysInfo.fromJson(sysInfoJson);

    return WeatherResponse(
        cityName: cityName,
        time: time,
        climateMeasurementInfo: measurementInfo,
        weatherInfo: weatherInfo,
        windInfo: windInfo,
        sysInfo: sysInfo,
        forecast: []);
  }

  static List<WeatherResponse> fromForecastJson(Map<String, dynamic> json) {
    final List<WeatherResponse> weathers = <WeatherResponse>[];
    for (final item in json['list']) {
      weathers.add(
        WeatherResponse(
          time: item['dt'],
          cityName: '',
          climateMeasurementInfo: ClimateMeasurementInfo(
              temperature: item['main']['temp'],
              minTemperature: 0.0,
              maxTemperature: 0.0,
              humidity: 0),
          weatherInfo: WeatherInfo(
              id: 0,
              main: '',
              description: '',
              iconCode: item['weather'][0]['icon']),
          windInfo: WindInfo(windSpeed: 0.0, deg: 0),
          sysInfo: SysInfo(sunrise: 0, sunset: 0),
          forecast: [],
        ),
      );
    }
    return weathers;
  }

  IconData getIconData() {
    switch (weatherInfo.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}
