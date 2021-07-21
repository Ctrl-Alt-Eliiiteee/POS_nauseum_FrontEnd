import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

String username = 'Soham';

String startDate = '___________';
String startTime = '___________';
String sessionDuration = '___________';

String doctorName = 'Soham';

String referralSource = 'Community GP';
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

String referralMode = 'In Person / Corridor';
List<String> referralModeDropDown = [
  'Email',
  'In Person / Corridor',
  'Telephone',
  'Postal / Courier service',
  'Video Conference',
  'Other',
];

String urn;
String dob = '___________';

String gender = 'Male';
List<String> genderDropDown = [
  'Male',
  'Female',
  'Transgender',
  'Non Binary',
  'Other',
];

String discipline = 'Consultant';
List<String> disciplineDropDown = [
  'Consultant',
  'Registrar',
  'CNC',
  'Psychologist',
  'Other',
];

String clTeam = 'Team 1';
List<String> clTeamDropDown = ['Team 1', 'Team 2', 'Team 3'];

String posCode = '10.01.00 Traige';
List<String> posCodeDropDown = [
  '10.01.00 Traige',
  '20.05.01 Review',
  '40.07.00 General Medicolegal'
];

String outcome = 'Other';
List<String> outcomeDropDown = [
  'MH Admission',
  'Discharge to GP',
  'Discahrge to ACT',
  'Discahrge to CCT',
  'Discahrge to no follow up',
  'Other'
];

String restuledInFormalReferral = 'N/A';
List<String> restuledInFormalReferralDropDown = [
  'Yes',
  'No',
  'N/A',
];

class _FormPageState extends State<FormPage> {
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                text: username,
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
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Doctors',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.06),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Name (for multiple names, add comma in between)',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.04),
                ),
              ),
              SizedBox(height: h * 0.01),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      doctorName = value;
                    });
                  },
                  controller: _doctorNameController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _doctorNameController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      hintText: 'Enter name(s)'),
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
              customText(h, w, 'Discipline'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, disciplineDropDown, 3),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'CL Team'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, clTeamDropDown, 4),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'POS Code'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, posCodeDropDown, 5),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Outcome'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, outcomeDropDown, 6),
              SizedBox(
                height: h * 0.02,
              ),
              customText(h, w, 'Resulted in formal referral'),
              SizedBox(height: h * 0.015),
              dropDownMenu(h, w, restuledInFormalReferralDropDown, 7),
              SizedBox(
                height: h * 0.02,
              ),
              Center(
                child: TextButton(
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
                  onPressed: () {},
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
                          ? discipline
                          : (index == 4)
                              ? clTeam
                              : (index == 5)
                                  ? posCode
                                  : (index == 6)
                                      ? outcome
                                      : restuledInFormalReferral,
          onChanged: (value) {
            setState(() {
              if (index == 0) {
                referralSource = value;
              } else if (index == 1) {
                referralMode = value;
              } else if (index == 2) {
                gender = value;
              } else if (index == 3) {
                discipline = value;
              } else if (index == 4) {
                clTeam = value;
              } else if (index == 5) {
                posCode = value;
              } else if (index == 6) {
                outcome = value;
              } else if (index == 7) {
                restuledInFormalReferral = value;
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
}
