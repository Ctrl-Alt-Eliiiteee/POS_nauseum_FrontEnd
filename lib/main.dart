import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos/Cal.dart';
import 'package:pos/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
String email;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();

  try {
    email = prefs.getString('POS_email');
    if (email == null) {
      email = '';
    }
  } catch (e) {}
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: (email.contains('@') && email.contains('.com'))
        ? HomePage(username: email)
        : LoginPage(),
  ));
}
