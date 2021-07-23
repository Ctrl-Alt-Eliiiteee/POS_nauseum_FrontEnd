import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Form.dart';
import 'package:pos/SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
String username='',password='';
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor('#c1e4ba'),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.only(left: w * 0.07, right: w * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("POS Nauseum",
                  style: TextStyle(
                      fontSize: w * 0.12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: h * 0.08),
            Text(
              "User id",
              style: TextStyle(
                color: HexColor('#272d25'),
                fontWeight: FontWeight.w300,
                fontSize: w * 0.05,
              ),
            ),
            SizedBox(height: h * 0.02),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                decoration: InputDecoration(border: InputBorder.none),
                onChanged: (status){
                  username=status;
                },
              ),
            ),
            SizedBox(height: h * 0.02),
            Text(
              "Password",
              style: TextStyle(
                color: HexColor('#272d25'),
                fontWeight: FontWeight.w300,
                fontSize: w * 0.05,
              ),
            ),
            SizedBox(height: h * 0.02),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(border: InputBorder.none),
                onChanged: (status){
                  password=status;
                },
              ),
            ),
            SizedBox(height: h * 0.04),
            TextButton(
              child: Container(
                  height: h * 0.05,
                  width: w * 0.9,
                  decoration: BoxDecoration(
                      color: HexColor('#485e43'),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: h * 0.03),
                  ))),
              onPressed: () async {
                try{
                  final check = await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FormPage()));
                }
                catch(e){
                  showSnackBar(e);
                }

              },
            ),
            SizedBox(height: h * 0.02),
            TextButton(
              child: Container(
                  height: h * 0.05,
                  width: w * 0.9,
                  decoration: BoxDecoration(
                      color: HexColor('#485e43'),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: h * 0.03),
                  ))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            )
          ],
        ),
      ),
    );
  }

  void showSnackBar(e) {
    final snackbar = SnackBar(content: Text(e));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
