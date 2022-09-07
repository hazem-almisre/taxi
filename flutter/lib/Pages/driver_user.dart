import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:location_get/Pages/Home.dart';
import 'package:location_get/Pages/home_driver.dart';

class DriverUser extends StatefulWidget {
  @override
  _DriverUerState createState() => _DriverUerState();
}

class _DriverUerState extends State<DriverUser> {
  bool Driver = true;
  double height = 120.0;

  int weight = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {});
                        var data = await SessionManager().get('data');
                        if (data != null && data['client'] != '0') {
                          if (data['token'] != '0' &&
                              data['client'] == 'driver') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => HomeScreenDriver()));
                          } else {
                            final snackBar =
                                SnackBar(content: Text('you are not driver'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => HomeScreenDriver()));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image:
                                  const AssetImage('assets/images/driver.png'),
                              height: 200.0,
                              width: 200.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Driver',
                              style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          color: Driver ? Colors.blue : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {});
                        var data = await SessionManager().get('data');
                        if (data != null && data['client'] != '0') {
                          if (data['token'] != '0' &&
                              data['client'] == 'user') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => HomeScreen()));
                          } else {
                            final snackBar =
                                SnackBar(content: Text('you are not user'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => HomeScreen()));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/user.png'),
                              height: 200.0,
                              width: 200.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'User',
                              style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Driver ? Colors.grey[400] : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
