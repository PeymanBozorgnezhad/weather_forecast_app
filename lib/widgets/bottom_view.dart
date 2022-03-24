import "package:flutter/material.dart";
import 'package:weather_app/models/weather.dart';
import '../widgets/forecast_card.dart';


class BottomView extends StatelessWidget {
  final AsyncSnapshot<WeatherResponse> snapshot;

  const BottomView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("5-day/3Hour Weather Forecast".toUpperCase(), style: const TextStyle(
            fontSize: 14,
            color: Colors.black87
        ),),
        Container(
          height: 170,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8,),
            itemCount: snapshot.data!.forecast.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                height: 160,
                child: forecastCard(snapshot, index),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xff9661C3), Colors.white],
                        begin: Alignment.topLeft, end: Alignment.bottomRight)
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
