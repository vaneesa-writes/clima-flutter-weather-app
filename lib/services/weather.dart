import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<Map<String, dynamic>> getWeatherDataFromLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    String lattitude = location.lattitude.toString();
    String longitude = location.longituude.toString();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': lattitude.toString(),
      'lon': longitude.toString(),
      'appid': '84285ad4c118b3742d2ec2454653c7ec',
      'units': '=metric'
    });
    Networking networking = Networking(url: url);
    return await networking.NetworkHelper();
  }

  Future<Map<String, dynamic>> getWeatherDataFromCity(String cityName) async {
    // Location location = Location();
    // await location.getCurrentLocation();
    // String lattitude = location.lattitude.toString();
    // String longitude = location.longituude.toString();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': cityName,
      // 'lon': longitude.toString(),
      'appid': '84285ad4c118b3742d2ec2454653c7ec',
      // 'units': '=metric'
    });
    Networking networking = Networking(url: url);
    return await networking.NetworkHelper();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
