import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepnote/screens/detail/detail.dart';

import '../login_screen/login_screen.dart';

class Welcome_screen extends StatefulWidget {
   Welcome_screen({super.key});
  @override
  State<Welcome_screen> createState() => _Welcome_screenState();
}

class _Welcome_screenState extends State<Welcome_screen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=> launchActivity(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/note.png",),
              SizedBox(height: 5,),
              Text("KeepNote", style: TextStyle(fontSize: 25),),
              SizedBox(height: 10,),
              const CircularProgressIndicator(color: Colors.limeAccent,),
            ],
          ),
        ),

      );
  }

  launchActivity() {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user?.uid == null) {
        Route route = MaterialPageRoute(builder: (context) => LoginScreen());
        Navigator.pushAndRemoveUntil(
            context, route, (Route<dynamic> route) => false);
      }
      else {
        Route route = MaterialPageRoute(builder: (context) => Detail());
        Navigator.pushAndRemoveUntil(
            context, route, (Route<dynamic> route) => false);
      }
    }catch(e){
      print(e.toString());
    }
  }
}

