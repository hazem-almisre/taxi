import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_get/Pages/requests.dart';
import 'dart:ui' as ui;

import 'Login.dart';
import 'Profile.dart';
import 'feedback.dart';
import 'login_driver.dart';

class HomeScreenDriver extends StatefulWidget {
  @override
  State<HomeScreenDriver> createState() => _HomeScreenState();
}

//for request
class UserModel {
  final int id;
  final String name;
  final String date;
  final String time;
  final String num;

  UserModel({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.num,
  });
}

//for session
class User {
  final int id;
  final String token;
  final String client;

  User({required this.id, required this.token, required this.client});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user["id"] = id;
    user["token"] = this.token;
    user["client"] = this.client;
    return user;
  }
}

class _HomeScreenState extends State<HomeScreenDriver> {
  var response;

  var dio = Dio();

  var massage;
  Location location = new Location();

  @override
  void initState() {
    // loadDataUser();
    super.initState();
    loadDataDriver();
    storeDriverLocation();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.4877533, 36.3445464),
    zoom: 20,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // foregroundColor: ,
          ),
      drawer: Drawer(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: ListView(
              children: [
                ListTile(
                  hoverColor: Colors.cyan,
                  title: Text(
                    '',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      var data = await SessionManager().get('data');
                      response = await dio.request(
                        "http://192.168.1.11:8000/driver/index/request/" +
                            data['id'].toString(),
                        data: {},
                        options: Options(method: 'GET', headers: {
                          'Authorization': 'Bearer ' + data['token']
                        }),
                      );
                      massage = response.data['massge'].toString();

                      if (massage == "succsesful") {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                RequestScreen(a: response.data['data'])));
                      } else {
                        final snackBar = SnackBar(
                            content: Text(response.data['massage'].toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text(
                    'Your Request',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      var data = await SessionManager().get('data');
                      response = await dio.request(
                        "http://192.168.1.11:8000/driver/show/" +
                            data['id'].toString(),
                        data: {},
                        options: Options(method: 'GET', headers: {
                          'Authorization': 'Bearer ' + data['token']
                        }),
                      );
                      massage = response.data['massge'].toString();
                      if (massage == "successful") {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage1(
                                name: response.data['data']['first_name'] +
                                    response.data['data']['last_name'],
                                email: response.data['data']['email'],
                                phone: response.data['data']['number'])));
                      } else {
                        final snackBar = SnackBar(
                            content: Text(response.data['massage'].toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    await SessionManager()
                        .set("data", new User(id: 0, token: '0', client:'0'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreenDriver()));
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FeedbackScreen()));
                  },
                  child: Text(
                    'feedback',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: false,
      ),
    );
  }

  void loadDataDriver() async {
    var data = await SessionManager().get('data');
    if (data == null || data['token'] == '0') {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreenDriver()));
    }
  }

  storeDriverLocation() async {
    var data = await SessionManager().get("data");
    if (data != null) {
      location.onLocationChanged.listen((LocationData currentLocation) {
        FirebaseFirestore.instance
            .collection('drivers')
            .doc(data['id'].toString())
            .set({
          'locations': GeoPoint(currentLocation.latitude!.toDouble(),
              currentLocation.longitude!.toDouble())
        });
      });
    }
  }
}
