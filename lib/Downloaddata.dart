import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DownloadDetails extends StatefulWidget {
  @override
  _DownloadDetailsState createState() => _DownloadDetailsState();
}

String _originalUsername;
String _originalPassword;

bool _isLoading = false;

String _adminUsername;
String _adminPassword;

class _DownloadDetailsState extends State<DownloadDetails> {
  @override
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
                        child: Text("Download POS eMetrics Data",
                            style: TextStyle(
                                fontSize: w * 0.09,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: h * 0.08),
                      Text(
                        "Admin id",
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
                            _adminUsername = status;
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
                            _adminPassword = status;
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
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Download",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: h * 0.03),
                                ),
                              ],
                            ))),
                        onPressed: () async {
                          // :TODO add the download file code

                          setState(() {
                            _isLoading = true;
                          });
                          await Future.delayed(
                              const Duration(seconds: 1), () {});
                          setState(() {
                            _isLoading = false;
                          });
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
                              "Change admin",
                              style: TextStyle(
                                  color: Colors.white, fontSize: h * 0.03),
                            ))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeAdminDetails()));
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

String _previousUsername;
String _previousPassword;
String _newUsername;
String _newPassword;

bool _isChangeLoading = false;

class ChangeAdminDetails extends StatefulWidget {
  @override
  _ChangeAdminDetailsState createState() => _ChangeAdminDetailsState();
}

class _ChangeAdminDetailsState extends State<ChangeAdminDetails> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor('#c1e4ba'),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: _isChangeLoading,
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
                        child: Text("Change Admin",
                            style: TextStyle(
                                fontSize: w * 0.11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: h * 0.08),
                      customTextfield(h, w, "Previous Admin ID", 0),
                      SizedBox(height: h * 0.02),
                      customTextfield(h, w, "Previous Admin password", 0),
                      SizedBox(height: h * 0.02),
                      customTextfield(h, w, "New Admin ID", 0),
                      SizedBox(height: h * 0.02),
                      customTextfield(h, w, "New Password", 0),
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
                              "Confirm Change",
                              style: TextStyle(
                                  color: Colors.white, fontSize: h * 0.03),
                            ))),
                        onPressed: () async {
                          // :TODO add the download file code

                          setState(() {
                            _isChangeLoading = true;
                          });
                          await Future.delayed(
                              const Duration(seconds: 1), () {});
                          setState(() {
                            _isChangeLoading = false;
                          });
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
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: h * 0.03),
                                ),
                              ],
                            ))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isChangeLoading
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

  Widget customTextfield(double h, double w, String heading, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
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
            onChanged: (value) {
              setState(() {
                if (index == 0) {
                  _previousUsername = value;
                } else if (index == 1) {
                  _previousPassword = value;
                } else if (index == 2) {
                  _newUsername = value;
                } else {
                  _newPassword = value;
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
