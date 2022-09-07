import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location_get/Pages/Home.dart';
import 'package:location_get/Pages/show_request.dart';

class UserModel {
  final int id;
  final String from;
  final String to;
  final String price;
  final String status;
  final String car_rating;
  final String time_waiting;

  UserModel({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.status,
    required this.car_rating,
    required this.time_waiting,
  });
}

class RequestScreen extends StatelessWidget {
  var a;
  RequestScreen({@required this.a});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        title: Text(
          'REQUESTS',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(a[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: a.length,
      ),
    );
  }

  Widget buildUserItem(dynamic user, context) => OutlinedButton(
        onPressed: () {
          print(user);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => showrequest(y: user)));
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,

                    child: Image(
                      image: AssetImage('assets/images/cabcab.png'),
                      // height: 10.0,
                      // width: 10.0,
                    ),
                    //
                    //   backgroundImage: NetworkImage(
                    //       'http://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkMUQW-__DIMDr3DupBGtBoyfix5C8r9uP0w&usqp=CAU'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user['from']}',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '${user['price']}',
                        style: TextStyle(
                          fontSize: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '${user['time_waiting']}',
                        style: TextStyle(
                          fontSize: 0.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
