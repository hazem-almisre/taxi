import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:location/location.dart';
import 'package:location_get/Pages/apply_request.dart';

class MakeRideRequest extends StatelessWidget {
  var from_x, from_y;
  MakeRideRequest({@required this.from_x, @required this.from_y});

  final _formkey = GlobalKey<FormState>();
  static var places = ['صالحية', 'ميدان', 'مزة', 'مالكي'];
  var dio = Dio();
  var response;
  var message;

  var to = TextEditingController();

  var data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text("Add Ride Request"),
            leading: IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff65b0bb),
                    Color(0xff5a9ea8),
                    Color(0xff508c95),
                    Color(0xff467b82),
                    Color(0xff3c6970),
                    Color(0xff32585d),
                    Color(0xff28464a),
                  ],
                ),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        constraints.maxWidth * 0.02,
                        constraints.maxHeight * 0.01,
                        constraints.maxWidth * 0.02,
                        constraints.maxHeight * 0.02,
                      ),
                      child: Card(
                        child: TextFormField(
                          enabled: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Start Point is your location",
                            prefixIcon: Icon(Icons.add_location_sharp,
                                color: Colors.blueAccent),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(width: 0.4),
                            //   borderRadius: BorderRadius.circular(15.0),
                            // ),
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ), //product name
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        constraints.maxWidth * 0.02,
                        constraints.maxHeight * 0.01,
                        constraints.maxWidth * 0.02,
                        constraints.maxHeight * 0.02,
                      ),
                      child: Card(
                        child: Autocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            }
                            return places.where((String option) {
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
                            to.text = selection;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        constraints.maxWidth * 0.28,
                        constraints.maxHeight * 0.01,
                        constraints.maxWidth * 0.28,
                        0,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (true) {
                            try {
                              var data = await SessionManager().get('data');
                              response = await dio.request(
                                "http://192.168.1.11:8000/api/store",
                                data: {
                                  "from_x": from_x,
                                  "from_y": from_y,
                                  "to": to.text.toString(),
                                },
                                options: Options(method: 'POST', headers: {
                                  'Authorization': 'Bearer ' + data['token']
                                }),
                              );
                              message = response.data['massge'].toString();
                              if (message == 'successful') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => apply_request(
                                        y: response.data['data'],price: response.data['price'],id: response.data['request'],)));
                              } else {
                                final snackBar = SnackBar(
                                    content: Text(
                                        response.data['massge'].toString()));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } catch (e) {}
                          }
                        },
                        child: Row(children: [
                          Text(
                            "Add Ride",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.05,
                          ),
                          Icon(Icons.my_library_add_outlined)
                        ]),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.fromLTRB(
                            constraints.maxWidth * 0.05,
                            constraints.maxHeight * 0.01,
                            constraints.maxWidth * 0.05,
                            constraints.maxHeight * 0.01,
                          )),
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal),
                        ),
                      ),
                    ), //add button
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  getRegisteredPlaces() async {
    places = (await dio.request("192.168.113.208/api/store",
            options: Options(
                method: 'GET',
                headers: {'Authorization': 'Bearer ' + data['token']})))
        as List<String>;
  }
}
