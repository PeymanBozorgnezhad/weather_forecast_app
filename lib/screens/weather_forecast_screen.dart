import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/data_service.dart';
import '../constants.dart';
import '../widgets/bottom_view.dart';
import '../widgets/mid_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherResponse> forecastObject;
  String _cityName = "Tehran";
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  String weatherIconUrl = 'http://openweathermap.org/img/wn/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastObject = getWeather(cityName: _cityName);
/*    forecastObject.then((weather) => {
      //[timezone] => not list type
      print("cod:" + weather.cod),
      // [minutely] => list type
      print(weather.list[0].dt)
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Forecasts"),
      ),
      body: ListView(
        children: [
          textFieldView(),
          Container(
            child: FutureBuilder<WeatherResponse>(
                future: forecastObject,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherResponse> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('Press button to start.');
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return const Text('Awaiting result...');
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return Column(
                        children: [
                          MidView(snapshot: snapshot),
                          BottomView(snapshot: snapshot),
                          // bottomView(snapshot, context)
                        ],
                      );
                  }
                }

                /*{
                    if(snapshot.hasData) {
                      return Column(
                        children: [
                          midView(snapshot),
                        ],
                      );
                    }else {
                      return Container(
                        child: CircularProgressIndicator(),);
                    }
                  }*/
                ),
          )
        ],
      ),
    );
  }

  Widget textFieldView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextField(
          controller: _cityTextController,
          decoration:
          InputDecoration(
            enabledBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(
                color: kColorInputDecoration,
              ),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(
                color: kColorInputDecoration,
              ),
            ),
            border:  OutlineInputBorder(
              borderSide: BorderSide(
                color: kColorInputDecoration,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            hintText: "Enter City Name",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: IconButton(
              onPressed: search,
              icon: Icon(
                Icons.search,
                color: kColorInputDecoration,
              ),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _cityTextController.clear(),
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
          onSubmitted: (value) {
            setState(() {
              _cityName = value;
              forecastObject = getWeather(cityName: _cityName);
            });
          },
        ),
      ),
    );
  }

  Future<WeatherResponse> getWeather({required String cityName}) =>
      _dataService.getWeather(city: _cityName);

  Future<WeatherResponse> search() {
    final response = _dataService.getWeather(city: _cityTextController.text);
    setState(() {
      forecastObject = response;
    });
    return forecastObject;
  }


}
