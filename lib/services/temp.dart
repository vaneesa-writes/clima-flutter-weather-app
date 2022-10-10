// import 'package:clima/services/location.dart';
// import 'package:clima/services/networking.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
// import 'location_screen.dart';
//
// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//   String lattitude = "", longitude = "";
//   initState() {
//     getLocationData();
//   }
//
//   Future<void> getLocationData() async {
//     Location location = Location();
//     await location.getCurrentLocation();
//     lattitude = location.lattitude.toString();
//     longitude = location.longituude.toString();
//     Networking networking =
//         Networking(lattitude: lattitude, longitude: longitude);
//     var weatherData = networking.NetworkHelper().then((value) {
//       // log('$value');
//       Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => LocationScreen(
//             weatherData: value,
//           ),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: SpinKitWave(
//           color: Colors.greenAccent,
//           type: SpinKitWaveType.start,
//           size: 100.0,
//         ),
//       ),
//     );
//   }
// }
