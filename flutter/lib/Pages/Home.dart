import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:location_get/Pages/Profile.dart';
import 'package:location_get/Pages/feedback.dart';
import 'package:location_get/Pages/feedback_user.dart';
import 'package:location_get/Pages/requests.dart';

//from mapsample
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'Login.dart';
import 'login_driver.dart';

import 'make_ride_request.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class User {
  final int id;
  final String token;
  final String client;

  User({required this.id, required this.token,required this.client});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user["id"] = id;
    user["token"] = this.token;
    user["client"] = this.client;
    return user;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var response;

  var dio = Dio();

  var massage;

  var mylat;
  var mylong;

  @override
  void initState() {
    // loadDataUser();
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) => print(value));

    loadDataUser();
    GetMarkerDriver();
  }

  //for map

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.4877533, 36.3445464),
    zoom: 20,
  );

  //markers
  List<Marker> _markers = <Marker>[];
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

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
                    'الصفحة الرئيسية',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      var data = await SessionManager().get('data');
                      print(data['token']);
                      response = await dio.request(
                        "http://192.168.43.228:8000/api/index/" +
                            data['id'].toString(),
                        data: {},
                        options: Options(method: 'GET', headers: {
                          'Authorization': 'Bearer ' + data['token']
                        }),
                      );
                      massage = response.data['massage'].toString();

                      if (massage == "successful") {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage1(
                                name: response.data['data']['first_name'],
                                email: response.data['data']['email'],
                                phone: response.data['data']['phone_number'])));
                        // name = response.data['data']['first_name'];
                        // email = response.data['data']['email'];
                        // phone = response.data['data']['phone_number'];
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
                    style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold,),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    var data = await SessionManager().get('data');
                    await SessionManager()
                        .set("data", new User(id: 0, token: '0',client: '0'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold,),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FeedbackScreenUser()));
                  },
                  child: Text(
                    'feedback',
                    style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold,),
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
                        "http://192.168.43.228:8000/api/index/request/" +
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
                            builder: (context) => RequestScreen(
                                a: response.data['data'])));
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
                    style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            )),
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          zoomControlsEnabled: false,
          markers: _markers.toSet(),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          child: BottomSheet(
            builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        Location l = new Location();
                        var z = await l.getLocation();
                        var from_x = z.latitude!.toDouble();
                        var from_y = z.longitude!.toDouble();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MakeRideRequest(
                                from_x: from_x, from_y: from_y)));
                      },
                      child: const Text('Request A Ride'))
                ],
              ),
            ),
            onClosing: () {},
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Location loc = new Location();
          var from = await loc.getLocation();
          var x = from.latitude!.toDouble();
          var y = from.longitude!.toDouble();
          _goToTheLake(x, y);
        },
        child: Icon(Icons.my_location_sharp),
      ),
    );
  }

  //for map
  Future<void> _goToTheLake(x, y) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(x, y),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
  }

  void loadDataUser() async {
    var data = await SessionManager().get('data');
    if (data == null || data['token'] == '0') {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  GetMarkerDriver() async {
    // await Firebase.initializeApp();

    FirebaseFirestore.instance
        .collection('drivers')
        .snapshots()
        .listen((event) {
      event.docChanges.forEach((change) async {
        final Uint8List markerIcon =
            await getBytesFromAsset('assets/images/cabcab.png', 100);
        _markers.add(Marker(
          markerId: MarkerId(change.doc.id),
          infoWindow: InfoWindow(title: change.doc.id),
          position: LatLng(change.doc.get('locations').latitude!.toDouble(),
              change.doc.get('locations').longitude!.toDouble()),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ));
        setState(() {});
      });
    });
  }
}
// helow word
