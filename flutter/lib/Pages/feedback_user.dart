import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:location_get/Pages/Home.dart';
import 'package:location_get/Pages/home_driver.dart';

class FeedbackScreenUser extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreenUser> {
  final controllertitle = TextEditingController();
  final controllerMessgae = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Giving Feedback App"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            buildTextField(
                title: "Title",
                controller: controllertitle,
                autoHint: "My Title"),
            SizedBox(
              height: 20,
            ),
            buildTextField(
                title: "Message",
                controller: controllerMessgae,
                maxLines: 8,
                autoHint: "My Message"),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(55),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text("SEND"),
              onPressed: () => {
                launchEmail(
                  title: controllertitle.text.toString(),
                  suggest_for_developer: controllerMessgae.text.toString(),
                ),
                      Navigator.of(context).pop(MaterialPageRoute(builder: (context) => HomeScreen()))
              },
            ),
          ],
        ),
      ),
    );
  }

  Future launchEmail({
    required String title,
    required String suggest_for_developer,
  }) async {
    var dio = Dio();
    var data = await SessionManager().get('data');
    final response = await dio.request(
      'http://192.168.1.11:8000/api/addSuggestion/' +
          data['id'].toString(),
      data: {
        "title": title,
        "user": "client",
        "suggest_for_developer": suggest_for_developer,
      },
      options: Options(
          method: 'POST',
          headers: {'Authorization': 'Bearer ' + data['token']}),
    );
    var massage = response.data['massge'].toString();
    if (massage == "successful") {
      final snackBar = SnackBar(content: Text(massage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text(massage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
    required String autoHint,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: autoHint,
            ),
          )
        ],
      );
}
