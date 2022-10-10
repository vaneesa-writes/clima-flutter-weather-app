import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String lattitude = "", longitude = "";
  initState() {
    getLocationData();
  }

  Future<void> getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeatherDataFromLocation();
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LocationScreen(
          weatherData: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SpinKitWave(
          color: Colors.greenAccent,
          type: SpinKitWaveType.start,
          size: 100.0,
        ),
      ),
    );
  }
}
