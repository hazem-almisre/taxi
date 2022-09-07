import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class apply_request extends StatelessWidget {
  var y,price,id;
  apply_request({@required this.y,@required this.price,@required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Show Request',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    buildFName(),
                    const SizedBox(
                      height: 35,
                    ),
                    buildLName(),
                    const SizedBox(
                      height: 35,
                    ),
                    buildEmail(),
                    const SizedBox(
                      height: 35,
                    ),
                    buildPassword(),
                    const SizedBox(
                      height: 35,
                    ),
                    Apply(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "From : ",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 9),
                )
              ]),
          child: FloatingActionButton.extended(
            heroTag: 'a',
            backgroundColor: const Color(0xffebefff),
            onPressed: () {},
            elevation: 0,
            label: Text(
              id['from'].toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "To : ",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 9),
                )
              ]),
          child: FloatingActionButton.extended(
            heroTag: 'a',
            backgroundColor: const Color(0xffebefff),
            onPressed: () {},
            elevation: 0,
            label: Text(
              id['to'].toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

 
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name Driver : ",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 9),
                )
              ]),
          child: FloatingActionButton.extended(
            heroTag: 'a',
            backgroundColor: const Color(0xffebefff),
            onPressed: () {},
            elevation: 0,
            label: Text(
              y['first_name'],
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price : ",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 9))
            ],
          ),
          height: 60,
          child: FloatingActionButton.extended(
            heroTag: 'a',
            backgroundColor: const Color(0xffebefff),
            onPressed: () {},
            elevation: 0,
            label: Text(
              price.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
  Widget Apply(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        const SizedBox(
          height: 8,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 9))
            ],
          ),
          height: 60,
          width: 60,
          child: FloatingActionButton.extended(
            heroTag: 'a',
            backgroundColor: const Color(0xffebefff),
            onPressed: () async{
              try {
                var data = await SessionManager().get('data');
                var dio=Dio();
                var response = await dio.request(
                  "http://192.168.1.11:8000/api/sendnotifiction/"+y['id'].toString(),
                  data: {
                  },
                  options: Options(method: 'GET',headers: {
                    'Authorization': 'Bearer ' + data['token']
                  }),
                );
                final snackBar = SnackBar(
                    content:
                    Text(response.data['massge']));
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
              } catch (e) {
                final snackBar = SnackBar(
                    content:
                    Text('have error in notfiction'));
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
              }
            },
            elevation: 0,
            label: Text(
              'Apply',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),SizedBox(width: 40,),Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 9))
            ],
          ),
          height: 60,
          width: 60,
          child: FloatingActionButton.extended(
            heroTag: 'a',
            backgroundColor: const Color(0xffebefff),
            onPressed: () async{
              try {
                var data = await SessionManager().get('data');
                var dio=Dio();
                var response = await dio.request(
                  "http://192.168.1.11:8000/api/destroy/"+id['id'].toString(),
                  data: {
                  },
                  options: Options(method: 'POST',headers: {
                    'Authorization': 'Bearer ' + data['token']
                  }),
                );
                var massge = response.data['massge'].toString();
                if(massge=='successful'){
                  final snackBar = SnackBar(
                      content:
                      Text(massge));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar);
                }
               else
                 {
                   final snackBar = SnackBar(
                       content:
                       Text(massge));
                   ScaffoldMessenger.of(context)
                       .showSnackBar(snackBar);
                 }
              } catch (e) {
                final snackBar = SnackBar(
                    content:
                    Text('have error in delet request'));
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
              }
            },
            elevation: 0,
            label: Text(
              'Deny',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );

  }

}

