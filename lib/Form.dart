import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Cal.dart';
import 'package:pos/helperfunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

String startDate = '___________';
String startTime = '___________';
String sessionDuration = '___________';

List<List<String>> doctorName = [];

int noOfDoctorTextFields = 1;

int noOfPosDropDowns = 1;

String referralSource = 'Community GP';
String referralMode = 'In Person / Corridor';
String urn;
String dob = '___________';
String gender = 'Male';
String clTeam = 'Team 1';
List<List<String>> posCode = [];
String outcome = 'Other';
String resultedInFormalReferral = 'N/A';
String comments;

List<String> referralSourceDropDown = [
  'Community GP',
  'Community Psycologist',
  'Community Psychiatrist',
  'Community Other',
  'Pain Team',
  'InPatient MH',
  'Hospital Exec and Ryan\'s rule',
  'Palliative Care'
];

List<String> referralModeDropDown = [
  'Email',
  'In Person / Corridor',
  'Telephone',
  'Postal / Courier service',
  'Video Conference',
  'Other',
];

List<String> genderDropDown = [
  'Male',
  'Female',
  'Transgender',
  'Non Binary',
  'Other',
];

List<String> disciplineDropDown = [
  'Consultant',
  'Registrar',
  'CNC',
  'Psychologist',
  'Other',
];

List<String> clTeamDropDown = ['Team 1', 'Team 2', 'Team 3'];

List<String> posCodeDropDown = [
  '10.01.00 Traige',
  '10.05.02 Risk Assessment',
  '20.01.07 Psycoeducation',
  '20.05.00 Pharmacotherapy Interventions',
  '20.05.01 Review (pharmacotherapy)',
  '20.05.02 Monitering (pharmacotherapy)',
  '20.05.04 Coordination (pharmacotherapy)',
  '20.08.00 Ongoing monitering and support',
  '20.09.00 Crisis response',
  '20.10.00 Family/Carer focused interventions',
  '20.99.00 Support, interventions and therapies NEC',
  '30.01.00 Coordination and Liaison',
  '30.01.01 Referral coordination',
  '30.01.02 Shared care',
  '30.01.03 Interagency stakeholder meeting',
  '30.01.04 Secondary consultation/education',
  '40.01.00 MHA advice and education',
  '40.02.00 MHA documentation and coordination',
  '40.04.00 MHRT',
  '40.04.01 MHRT report',
  '40.06.00 QLD Civil and Administrative Tribunal',
  '40.07.00 General Medicolegal',
  '50.04.00 Triage/Intake review'
];

List<String> outcomeDropDown = [
  'MH Admission',
  'Discharge to GP',
  'Discahrge to ACT',
  'Discahrge to CCT',
  'Discahrge to no follow up',
  'Other'
];

List<String> restuledInFormalReferralDropDown = [
  'Yes',
  'No',
  'N/A',
];

class FormPage extends StatefulWidget {
  final String username;

  const FormPage({Key key, this.username}) : super(key: key);
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  void initState() {
    super.initState();
    print(widget.username);
    startDate = '___________';
    startTime = '___________';
    sessionDuration = '___________';
    doctorName.add(['', 'Consultant']);
    referralSource = 'Community GP';
    referralMode = 'In Person / Corridor';
    urn = '';
    dob = '___________';
    gender = 'Male';
    clTeam = 'Team 1';
    posCode.add(['10.01.00 Traige', '0']);
    outcome = 'Other';
    resultedInFormalReferral = 'N/A';
    comments = '';
  }

  @override
  Widget build(BuildContext context) {
    var _doctorNameController = TextEditingController();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: h,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    border: Border.all(
                      color: HexColor('#82cb70'),
                    )),
                child: Column(
                  children: [
                    SizedBox(height: h * 0.05),
                    Padding(
                      padding:
                          EdgeInsets.only(left: w * 0.035, right: w * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'User\n',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: widget.username,
                                style: TextStyle(
                                    color: HexColor('#82cb70'),
                                    fontSize: w * 0.05))
                          ])),
                          IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                size: w * 0.08,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Details',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.06),
                ),
              ),
              SizedBox(height: h * 0.02),
              customText(h, w, 'Start Date and Time'),
              Padding(
                padding: EdgeInsets.only(left: 10, right: w * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      label: Text(
                        startDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w400),
                      ),
                      onPressed: () async {
                        DateTime _dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (_dateTime != null) {
                          setState(() {
                            startDate = _dateTime.day.toString() +
                                '/' +
                                _dateTime.month.toString() +
                                '/' +
                                _dateTime.year.toString();
                          });
                        }
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.timer,
                        color: Colors.black,
                      ),
                      label: Text(
                        startTime,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w400),
                      ),
                      onPressed: () async {
                        TimeOfDay _timeOfDay = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (_timeOfDay != null) {
                          setState(() {
                            startTime = _timeOfDay.format(context);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              customText(h, w, 'Time Duration'),
              SizedBox(height: h * 0.015),
              Padding(
                padding: EdgeInsets.only(left: w * 0.02),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.timer,
                    color: Colors.black,
                  ),
                  label: Text(
                    sessionDuration,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async {
                    TimeOfDay _timeOfDay = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (_timeOfDay != null) {
                      setState(() {
                        sessionDuration = _timeOfDay.format(context);
                        String ans = "";
                        for (int i = 0; i < sessionDuration.length; i++) {
                          if (sessionDuration[i] == ' ') {
                            break;
                          }
                          ans += sessionDuration[i];
                        }
                        sessionDuration = ans;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.035),
                    child: Text(
                      'Clinicians',
                      style: TextStyle(color: Colors.black, fontSize: w * 0.06),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        noOfDoctorTextFields += 1;
                        doctorName.add(['', 'Consultant']);
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Text(
                      'Remove',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if (noOfDoctorTextFields > 1) {
                          noOfDoctorTextFields -= 1;
                          doctorName.removeLast();
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Name(s)',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.04),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.green)),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: noOfDoctorTextFields,
                    itemBuilder: (BuildContext context, int index) {
                      return ClinicianNames(h, w, index);
                    },
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              customText(h, w, 'Referral source'),
              SizedBox(
                height: h * 0.015,
              ),
              dropDownMenu(h, w, referralSourceDropDown, 0),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Referral mode'),
              SizedBox(
                height: h * 0.015,
              ),
              dropDownMenu(h, w, referralModeDropDown, 1),
              SizedBox(height: h * 0.02),
              customText(h, w, 'Date of birth'),
              SizedBox(height: h * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  label: Text(
                    dob,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async {
                    DateTime _dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (_dateTime != null) {
                      setState(() {
                        dob = _dateTime.day.toString() +
                            '/' +
                            _dateTime.month.toString() +
                            '/' +
                            _dateTime.year.toString();
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: h * 0.02),
              customText(h, w, 'URN'),
              SizedBox(height: h * 0.01),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      urn = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'URN'),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Gender'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, genderDropDown, 2),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'CL Team'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, clTeamDropDown, 3),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  customText(h, w, 'Intervention'),
                  SizedBox(width: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        noOfPosDropDowns += 1;
                        posCode.add(['10.01.00 Traige', '']);
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Text(
                      'Remove',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if (noOfPosDropDowns > 1) {
                          noOfPosDropDowns -= 1;
                          posCode.removeLast();
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: h * 0.015),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.green)),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: noOfPosDropDowns,
                    itemBuilder: (BuildContext context, int index) {
                      return Interventions(h, w, index);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Outcome'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, outcomeDropDown, 5),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Resulted in formal referral'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, restuledInFormalReferralDropDown, 6),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Comments'),
              SizedBox(height: h * 0.015),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035, right: 20),
                child: TextFormField(
                  minLines: null,
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      comments = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Comments'),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  child: Container(
                      height: h * 0.05,
                      width: w * 0.9,
                      decoration: BoxDecoration(
                          color: HexColor('#485e43'),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "Save",
                        style:
                            TextStyle(color: Colors.white, fontSize: h * 0.03),
                      ))),
                  onPressed: () async {
                    // print(startDate +
                    //     ' ' +
                    //     startTime +
                    //     ' ' +
                    //     sessionDuration +
                    //     ' ' +
                    //     doctorName.toString() +
                    //     ' ' +
                    //     referralSource +
                    //     ' ' +
                    //     referralMode +
                    //     ' ' +
                    //     dob +
                    //     ' ' +
                    //     urn +
                    //     ' ' +
                    //     gender +
                    //     ' ' +
                    //     discipline +
                    //     ' ' +
                    //     clTeam +
                    //     ' ' +
                    //     posCode +
                    //     ' ' +
                    //     outcome +
                    //     ' ' +
                    //     resultedInFormalReferral +
                    //     ' ' +
                    //     comments);
                    print("Clinician name");
                    print(doctorName);
                    print("Intervention Code");
                    print(posCode);
                    // String ans = await uploadDetails();
                    // showSnackBar(ans);
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // String username = prefs.getString('POS_email');
                    // print(username);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomePage(
                    //               username: username,
                    //             )));
                  },
                ),
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }

  Widget customText(double h, double w, String text) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.035),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: w * 0.05),
      ),
    );
  }

  Widget dropDownMenu(
      double h, double w, List<String> dropDownItems, int index) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.06, right: 30),
      child: Container(
        padding: EdgeInsets.only(left: w * 0.035, right: w * 0.035),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey[300])),
        child: DropdownButton(
          underline: SizedBox(),
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            color: HexColor('#82cb70'),
          ),
          isExpanded: true,
          iconSize: w * 0.07,
          value: (index == 0)
              ? referralSource
              : (index == 1)
                  ? referralMode
                  : (index == 2)
                      ? gender
                      : (index == 3)
                          ? clTeam
                          : (index == 4)
                              ? posCode
                              : (index == 5)
                                  ? outcome
                                  : resultedInFormalReferral,
          onChanged: (value) {
            setState(() {
              if (index == 0) {
                referralSource = value;
              } else if (index == 1) {
                referralMode = value;
              } else if (index == 2) {
                gender = value;
              } else if (index == 3) {
                clTeam = value;
              } else if (index == 4) {
                posCode = value;
              } else if (index == 5) {
                outcome = value;
              } else if (index == 6) {
                resultedInFormalReferral = value;
              }
            });
          },
          items: dropDownItems.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),
        ),
      ),
    );
  }

  void showSnackBar(String ans) {
    final snackBar = SnackBar(content: Text(ans));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget ClinicianNames(double h, double w, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: h * 0.02),
        Padding(
          padding: EdgeInsets.only(left: w * 0.035),
          child: Text(
            (index + 1).toString() + ". Clinician name",
            style: TextStyle(color: Colors.black, fontSize: w * 0.04),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: w * 0.06, right: 20),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                doctorName[index][0] = value;
              });
            },
            decoration: InputDecoration(hintText: 'Clinician name'),
          ),
        ),
        SizedBox(height: h * 0.015),
        Padding(
          padding: EdgeInsets.only(left: w * 0.035),
          child: Text(
            (index + 1).toString() + ". Discipline",
            style: TextStyle(color: Colors.black, fontSize: w * 0.04),
          ),
        ),
        SizedBox(height: h * 0.015),
        Padding(
          padding: EdgeInsets.only(left: w * 0.06, right: 30),
          child: Container(
            padding: EdgeInsets.only(left: w * 0.035, right: w * 0.035),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey[300])),
            child: DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.arrow_drop_down_sharp,
                color: HexColor('#82cb70'),
              ),
              isExpanded: true,
              iconSize: w * 0.07,
              value: doctorName[index][1],
              onChanged: (value) {
                setState(() {
                  doctorName[index][1] = value;
                });
              },
              items: disciplineDropDown.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget Interventions(double h, double w, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: h * 0.02),
        Padding(
          padding: EdgeInsets.only(left: w * 0.035),
          child: Text(
            (index + 1).toString() + ". Intervention",
            style: TextStyle(color: Colors.black, fontSize: w * 0.04),
          ),
        ),
        SizedBox(height: h * 0.01),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.06, right: 30),
              child: Container(
                padding: EdgeInsets.only(left: w * 0.035, right: w * 0.035),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey[300])),
                child: DropdownButton(
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: HexColor('#82cb70'),
                  ),
                  iconSize: w * 0.07,
                  isExpanded: true,
                  value: posCode[index][0],
                  onChanged: (value) {
                    setState(() {
                      posCode[index][0] = value;
                    });
                  },
                  items: posCodeDropDown.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Container(
              padding: EdgeInsets.only(right: w / 2, left: w * 0.06),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    posCode[index][1] = value;
                  });
                },
                decoration: InputDecoration(hintText: 'Time (in minutes)'),
              ),
            )
          ],
        ),
        SizedBox(height: h * 0.015),
      ],
    );
  }
}
