import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  var weatherData;
  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  int condition = 0;
  String cityName = '', weatherIcon = '', message = '';
  bool _isLoading = false;
  WeatherModel weatherModel = WeatherModel();
  initState() {
    updateUI(widget.weatherData);
  }

  void updateUI(var weatherData) {
    if (weatherData == null) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: "Kindly check your Internet connection , location service",
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    setState(() {
      temperature = (weatherData['main']['temp'] - 273.15).toInt();
      condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temperature);
      cityName = weatherData['name'];
    });

    // log('$temperature' + ' ' + '$condition' + ' ' + '$cityName');
  }

  Future<void> _getCityNameAndWeather(BuildContext context) async {
    String result = 'none';
    setState(() {
      _isLoading = true;
    });
    result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CityScreen()),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context)..removeCurrentSnackBar();
    //   ..showSnackBar(SnackBar(content: Text('$result')));
    WeatherModel weatherModel = WeatherModel();
    if (result != 'none') {
      var weatherData = await weatherModel.getWeatherDataFromCity(result);
      updateUI(weatherData);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SpinKitWave(
                color: Colors.greenAccent,
                type: SpinKitWaveType.start,
                size: 100.0,
              ),
            ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/location_background.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            var weatherData =
                                await weatherModel.getWeatherDataFromLocation();
                            updateUI(weatherData);
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            _getCityNameAndWeather(context);
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            temperature.toString() + '°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherIcon,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Container(
                          margin: EdgeInsets.all(40.0),
                          child: Text(
                            message + ' in ' + cityName,
                            textAlign: TextAlign.right,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
