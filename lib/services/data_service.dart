import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

import '../http_exception/custom_exception.dart';

class DataService {
  Future<WeatherResponse> getWeather({required String city}) async {
    final queryParameters = {
      'q': city,
      'appid': '53675bdbe5525279d2584c1d7ec92418'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    http.Response response = await http.get(uri);
    if (response.statusCode != 200) {
      throw HTTPException(
          code: response.statusCode, message: "unable to fetch weather data");
    }
    final json = jsonDecode(response.body);
    print(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<List<WeatherResponse>> getForecast(String cityName) async {
    final queryParameters = {
      'q': cityName,
      'appid': '53675bdbe5525279d2584c1d7ec92418'
    };
    final uri = Uri.https(
        'api.openweathermap.org', 'data/2.5/forecast', queryParameters);
    http.Response response = await http.get(uri);
    if (response.statusCode != 200) {
      HTTPException(
          code: response.statusCode, message: "unable to fetch weather data");
    }
    final foreCastJson = jsonDecode(response.body);
    List<WeatherResponse> weathers =
        WeatherResponse.fromForecastJson(foreCastJson);
    return weathers;
  }
}
