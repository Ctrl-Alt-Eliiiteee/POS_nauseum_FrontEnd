import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

String _emailID = '';

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: HexColor('#c1e4ba'),
        body: Center(
          child: Container(
            width: w,
            padding: EdgeInsets.only(left: w * 0.07, right: w * 0.07),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Forgot Password",
                        style: TextStyle(
                            fontSize: w * 0.1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: h * 0.08),
                  Text(
                    "Mail id",
                    style: TextStyle(
                      color: HexColor('#272d25'),
                      fontWeight: FontWeight.w300,
                      fontSize: w * 0.05,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(border: InputBorder.none),
                      onChanged: (status) {
                        _emailID = status;
                      },
                    ),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    "* In order to reset your password, an email will be sent to the above filled ID which will contain a link to change the password",
                    style: TextStyle(
                      color: HexColor('#272d25'),
                      fontWeight: FontWeight.w300,
                      fontSize: w * 0.04,
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                    child: Container(
                        height: h * 0.05,
                        width: w * 0.9,
                        decoration: BoxDecoration(
                            color: HexColor('#485e43'),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white, fontSize: h * 0.03),
                        ))),
                    onPressed: () {
                      if (_emailID.isEmpty) {
                        showSnackBar("Please enter a valid mail id");
                      } else {
                        showSnackBar("Email has been sent");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void showSnackBar(e) {
    final snackbar = SnackBar(content: Text(e));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
