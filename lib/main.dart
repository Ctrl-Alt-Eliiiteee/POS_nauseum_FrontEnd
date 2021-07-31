import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos/Cal.dart';
import 'package:pos/Login.dart';
import 'package:pos/helperfunctions.dart';
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
  // var obj = await getdetails();
  //   // for(var i in obj){
  //   //   print(i.doctorNames[0].values.toList()[0]);
  //   //   print(i.startTime+" "+i.startDate+" "+i.comments);
  //   //
  //   // }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
