import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
// import 'package:pro/home_screen.dart';
// import 'package:Pages/login_model.dart';
// import 'package:pro/services/login_api.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:location_get/Pages/Register.dart';
import 'package:http/http.dart' as http;

import 'Home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
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

class _LoginScreenState extends State<LoginScreen> {
  // late loginRequestModel login_requestModel;
  // AuthApi login_api = AuthApi();
  var response;
  var token;
  var massage;
  var dio = Dio();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool passwordShow = true;
  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop:changeScreen,
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (!EmailValidator.validate(value!)) {
                              return 'email address is not correct';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: passwordShow,
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordShow = !passwordShow;
                                });
                              },
                              icon: Icon(
                                passwordShow
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          color: const Color(0xff3c6970),
                          child: MaterialButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                try {
                                  response = await dio.request(
                                    "http://192.168.43.65:8000/api/user/login",
                                    data: {
                                      "email": emailController.text.toString(),
                                      "password":
                                          passwordController.text.toString()
                                    },
                                    options: Options(method: 'POST'),
                                  );
                                  massage = response.data['massage'];
                                  if (massage == "successful" &&
                                      response.data['data']['token'] != '') {
                                    int id = response.data['data']['id'];
                                    String token =
                                        response.data['data']['token'];
                                    String client =
                                    response.data['cilent'];
                                    await SessionManager().set(
                                        "data", new User(id: id, token: token,client:client));
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomeScreen()));
                                  } else {
                                    final snackBar = SnackBar(
                                        content: Text(massage.toString()));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } catch (e) {
                                  final snackBar = SnackBar(
                                      content:
                                          Text('you have exception in code'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Register()));
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  changeScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
