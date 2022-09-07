import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_session_manager/flutter_session_manager.dart';


class ProfilePage1 extends StatelessWidget {

  var name,email,phone;
  ProfilePage1({@required this.name,@required this.email,@required this.phone});

  var response;
  var dio = Dio();
  var massage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff65b0bb),
        child: Column(
          children: [
            const Expanded(flex: 2, child: _TopPortion()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(name,
                        style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold,)
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 400.0,
                      height: 50.0,
                      child: FloatingActionButton.extended(
                        heroTag: 'a',
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        elevation: 0,
                        label:  Text('Email: '+email,style: TextStyle(color: Colors.black,fontSize: 18.0,),),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 400.0,
                      height: 50.0,
                      child: FloatingActionButton.extended(
                        heroTag: 'b',
                        onPressed: () {},
                        elevation: 0,
                        backgroundColor: Colors.white,
                        label: Text('Phone: '+phone,style: TextStyle(color: Colors.black,fontSize: 18.0,), ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xff65b0bb),
                  Color(0xff5a9ea8),
                  Color(0xff508c95),
                  Color(0xff467b82),
                  Color(0xff3c6970),
                  Color(0xff32585d),
                  Color(0xff28464a),
                ],),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/user.png'),),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}