import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Cal.dart';
import 'package:pos/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csv/csv.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

String username = '', password = '';

bool _isLoading = false;

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  getDatabaseData() async {
    CollectionReference databaseRef =
        FirebaseFirestore.instance.collection('Details');

    // extract all username id
    QuerySnapshot userQuerySnapshot = await databaseRef.get();
    final users = userQuerySnapshot.docs.map((doc) => doc.id).toList();

    List<List<dynamic>> rows = [];
    bool firstRun = true;
    for (var user in users) {
      // extract all data from user's collection
      QuerySnapshot detailQuerySnapshot =
          await databaseRef.doc(user).collection('Timings').get();
      final details =
          detailQuerySnapshot.docs.map((doc) => doc.data()).toList();

      for (var data in details) {
        // json encoding of data
        var jsonData = jsonDecode(jsonEncode(data));

        Map details = {
          'Username': user,
          'Start Date': jsonData['Start Date'],
          'Start Time': jsonData['Start Time'],
          'Duration': jsonData['Duration'],
          'Referral Source': jsonData['Referral Source'],
          'Referral Mode': jsonData['Referral Mode'],
          'DOB': jsonData['DOB'],
          'URN': jsonData['URN'],
          'Gender': jsonData['Gender'],
          "Clinicians": jsonEncode(jsonData['Clinicians']),
          'CL Team': jsonData['CL Team'],
          'POS CodeList': jsonEncode(jsonData['POS CodeList']),
          'Outcome': jsonData['Outcome'],
          'Resulted in formal referral':
              jsonData['Resulted in formal referral'],
          'Comments': jsonData['Comments'],
        };

        if (firstRun) {
          firstRun = !firstRun;
          rows.add(details.keys.toList()); // heading of csv file
        }

        rows.add(details.values.toList());
      }
    }
    return rows;
  }

  File details = File('');
  Directory downloadsDirectory = Directory('');
  getDownloadPath() async {
    try {
      downloadsDirectory = await DownloadsPathProvider
          .downloadsDirectory; // download folder directory
      print('Download Directory Found!');

      // TODO: make an application specific folder inside the download directory
      details =
          File(downloadsDirectory.path + "/pos_details.csv"); // make a csv file
    } on PlatformException {
      print('Could not get the downloads directory');
    }
  }

  generateCSV() async {
    await getDownloadPath();

    // extract all data as a 2D List
    var rows = await getDatabaseData();
    String csv = ListToCsvConverter().convert(rows);

    try {
      // populate the csv file
      await details.writeAsString(csv);
      print('CSV File Saved Successfully!');
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor('#c1e4ba'),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: _isLoading,
            child: Center(
              child: Container(
                width: w,
                padding: EdgeInsets.only(left: w * 0.07, right: w * 0.07),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("POS eMetrics",
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
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (status) {
                            username = status;
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
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (status) {
                            password = status;
                          },
                        ),
                      ),
                      SizedBox(height: h * 0.06),
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
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: h * 0.03),
                            ))),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          try {
                            // final check = await FirebaseAuth.instance.sendPasswordResetEmail(email: username);
                            final check = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: username, password: password);

                            prefs.setString('POS_email', username);
                            setState(() {
                              _isLoading = false;
                            });
                            if (check.user.emailVerified) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            username: username,
                                          )));
                            } 
                          } catch (e) {
                            setState(() {
                              _isLoading = false;
                            });
                            showSnackBar("Invalid email or password");
                          }
                        },
                      ),
                      SizedBox(height: h * 0.03),
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
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white, fontSize: h * 0.03),
                            ))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isLoading
              ? Container(
                  height: h,
                  width: w,
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void showSnackBar(e) {
    final snackbar = SnackBar(content: Text(e));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
