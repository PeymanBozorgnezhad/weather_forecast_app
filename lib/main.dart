import 'package:flutter/material.dart';
import '../screens/weather_forecast_screen.dart';
import '/constants.dart';
import '../models/weather.dart';
import '../services/data_service.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherForecastScreen(),
    ),
  );
}

/*class MyWeather extends StatefulWidget {
  const MyWeather({Key? key}) : super(key: key);

  @override
  State<MyWeather> createState() => _MyWeatherState();
}*/

/*class _MyWeatherState extends State<MyWeather> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
 // late WeatherResponse _response;

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
   */ /* setState(() {
      _response = response;
    });*/ /*

     print(
        'city name : ${response.cityName}\ntemperature : ${response.climateMeasurementInfo.temperature}\nweather ===> ${'icon : ${response.weatherInfo.iconCode}\t description : ${response.weatherInfo.description}'}');
    print('speed : ${response.windInfo.windSpeed}');
    print('deg : ${response.windInfo.deg}');
  }

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kBackColorScaffold,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: TextField(
                    controller: _cityTextController,
                    decoration: InputDecoration(
                        prefixIcon: Material(
                          color: Colors.white,
                          child: IconButton(
                            splashRadius: 15,
                            icon: const Icon(
                              Icons.search,
                            ),
                            onPressed: _search,
                          ),
                        ),
                        suffixIcon: Material(
                          color: Colors.white,
                          child: IconButton(
                            splashRadius: 15,
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                                //Clear the search field
                              _cityTextController.clear();
                            },
                          ),
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              ),
               */ /*if (_response != null)
                Column(
                  children: [
                    Text(
                      '${_response.climateMeasurementInfo.temperature}°',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      _response.weatherInfo.description,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),*/ /*
            ],
          ),
        ),
      ),
    );
  }
}*/
