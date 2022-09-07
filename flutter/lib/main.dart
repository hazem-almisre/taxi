import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:location_get/Pages/Home.dart';
import 'package:location_get/Pages/feedback.dart';
import 'package:location_get/Pages/home_driver.dart';
import 'package:location_get/Pages/make_ride_request.dart';
import 'package:location_get/Pages/requests.dart';
import 'package:location_get/Pages/show_request.dart';
import 'dart:async';
import 'Pages/Login.dart';
import 'Pages/Profile.dart';
import 'Pages/driver_user.dart';
import 'Pages/login_driver.dart';
import 'Pages/register_drive.dart';
import 'package:location/location.dart';

void pri() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (_serviceEnabled) {
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.granted) {
      // _location = await location.getLocation();

      // print(_location.latitude.toString() + " " + _location.longitude.toString());

      // location.onLocationChanged.listen((LocationData currentLocation) {
      //   print(currentLocation.latitude.toString() +
      //       " " +
      //       currentLocation.longitude.toString());
      // });
    } else {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        print('user allowed');
      } else {
        SystemNavigator.pop();
      }
    }
  } else {
    _serviceEnabled = await location.requestService();

    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        print('user allowed before');
      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      SystemNavigator.pop();
    }
  }
}


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher,
  //     isInDebugMode: true
  // );
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pri();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps Demo',
      home: DriverUser(),
      routes: {
        'ProfilePage': (context) => ProfilePage1(),
        'RequestScreen': (context) => RequestScreen(),
        'showrequest': (context) => showrequest(),
      },
    );
  }
}
