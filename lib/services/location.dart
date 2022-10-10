import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class Location {
  double lattitude = 0, longituude = 0;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lattitude = position.latitude;
      longituude = position.longitude;
      // log('$lattitude');
    } catch (e) {
      log(e.toString());
    }
    // log('$position');
  }
}
