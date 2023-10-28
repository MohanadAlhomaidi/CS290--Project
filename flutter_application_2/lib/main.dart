import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/HomePage.dart';
import 'package:flutter_application_2/Pages/IntroductionPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check if the user is already signed in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use a Conditional Expression to determine the initial route
      initialRoute: user != null ?  '/' : '/home',
      routes: {
        '/': (context) => IntroductionPage(),
        '/home': (context) => HomePage(),
      },
    ),
  );
}
