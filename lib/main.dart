import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keepnote/screens/welcome_screen/welcome_screen.dart';
import 'firebase_options.dart';
import 'screens/otp_screen/otp_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeepNote',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 253, 188, 51),
      ),
      home: Welcome_screen(),
     // routes: <String, WidgetBuilder>{
     //   '/otpScreen': (BuildContext ctx) => OtpScreen(),
     // },
    );
  }
}
