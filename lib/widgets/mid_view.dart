import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/weather.dart';
import '../utils/forecast_util.dart';

class MidView extends StatelessWidget {
  final AsyncSnapshot<WeatherResponse> snapshot;

  const MidView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data;
    var time = forecastList?.time ?? 0;
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var temp = forecastList?.climateMeasurementInfo.temperature ?? 0.0;
    var temperature = (temp + 273.15).toStringAsFixed(0);
    var maxTemp = forecastList?.climateMeasurementInfo.maxTemperature ?? 0.0;
    var maxTemperature = (maxTemp - 273.15).toStringAsFixed(0);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${forecastList?.cityName}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            Text(
              Util.getFormattedDate(formattedDate),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Icon(
              forecastList?.getIconData(),
              size: 170,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "$temperature°C",
                      style: const TextStyle(fontSize: 34),
                    ),
                  ),
                  Text(
                    '${forecastList?.weatherInfo.description.toUpperCase()}',
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${forecastList?.windInfo.windSpeed.toStringAsFixed(1)} mi/h",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Icon(
                            FontAwesomeIcons.wind,
                            size: 30,
                            color: Colors.brown,
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${forecastList?.climateMeasurementInfo.humidity.toStringAsFixed(0)} %",
                            style: const TextStyle(fontSize: 18)),
                        const Icon(
                          FontAwesomeIcons.solidFaceGrinBeamSweat,
                          size: 30,
                          color: Colors.brown,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$maxTemperature°C",
                            style: const TextStyle(fontSize: 18)),
                        const Icon(
                          FontAwesomeIcons.temperatureHigh,
                          size: 30,
                          color: Colors.brown,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
