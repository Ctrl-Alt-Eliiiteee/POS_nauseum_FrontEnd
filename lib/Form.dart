import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Cal.dart';
import 'package:pos/helperfunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:intl/intl.dart';

String startDate = '___________';
String startTime = '___________';
String sessionDuration;

List<List<String>> doctorName = [];

int noOfDoctorTextFields = 1;

int noOfPosDropDowns = 1;

bool _isLoading = false;

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
  'Med 1A',
  'Med 1B',
  'Med 2A',
  'Med 2B',
  'Med 3A',
  'Med 3B',
  'Med 4A',
  'Med 4B',
  'RESP',
  'CARD',
  'STROKE',
  'NEURO',
  'ENDO',
  'RHEUM',
  'ID',
  'ICU',
  'BURNS',
  'RENAL',
  'EPIC',
  'HAEM',
  'ONC',
  'GYN ONC',
  'DERM',
  'MDPC',
  'ENT',
  'PLASTICS',
  'MAX FAX',
  'THORACIC',
  'ORTHO 1',
  'ORTHO TRAUMA',
  'ORTHO 3',
  'ORTHO 4 & 5',
  'GASTRO LIVER',
  'MATERNITY ',
  'GYN OPD',
  'VASCULAR',
  'OPTHAL',
  'IHT MED',
  'IHT MH & CL',
  'Community MH',
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
  '10.01.00 Triage',
  '10.05.02 Risk Assessment',
  '20.01.07 Psychoeducation',
  '20.05.00 Pharmacotherapy Interventions',
  '20.05.01 Review (pharmacotherapy)',
  '20.05.02 Monitoring (pharmacotherapy)',
  '20.05.04 Coordination (pharmacotherapy)',
  '20.08.00 Ongoing monitoring and support',
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
  'Discharge to ACT',
  'Discharge to CCT',
  'Discharge to no follow up',
  'Other'
];

List<String> restuledInFormalReferralDropDown = [
  'Yes',
  'No',
  'N/A',
];

class FormPage extends StatefulWidget {
  String username;
  int check;
  String startDate;
  String startTime;
  String sessionDuration;
  List doctorName = [];
  String referralSource;
  String referralMode;
  String dob;
  String urn;
  String gender;
  String clTeam;
  List posCode = [];
  String outcome;
  String resultedInFormalReferral;
  String comments;
  FormPage(
      {Key key,
      this.username,
      this.check,
      this.startDate,
      this.startTime,
      this.sessionDuration,
      this.doctorName,
      this.referralSource,
      this.referralMode,
      this.dob,
      this.urn,
      this.gender,
      this.clTeam,
      this.posCode,
      this.outcome,
      this.resultedInFormalReferral,
      this.comments})
      : super(key: key);
  @override
  _FormPageState createState() => _FormPageState();
}

String savedDate = '', Savedtime = '';

class _FormPageState extends State<FormPage> {
  void initState() {
    super.initState();
    print(widget.username);
    if (widget.check == 0) {
      noOfDoctorTextFields = 1;
      noOfPosDropDowns = 1;
      doctorName = [];
      posCode = [];
      startDate = '___________';
      startTime = '___________';
      sessionDuration = '0';
      doctorName.add(['', 'Consultant']);
      referralSource = 'Med 1A';
      referralMode = 'In Person / Corridor';
      urn = '';
      dob = '___________';
      gender = 'Male';
      clTeam = 'Team 1';
      posCode.add(['10.01.00 Traige', '']);
      outcome = 'Other';
      resultedInFormalReferral = 'N/A';
      comments = '';
      _isLoading = false;
    } else {
      doctorName = [];
      posCode = [];
      startDate = widget.startDate;
      startTime = widget.startTime;
      sessionDuration = widget.sessionDuration;
      referralSource = widget.referralSource;
      referralMode = widget.referralMode;
      urn = widget.urn;
      dob = widget.dob;
      gender = widget.gender;
      clTeam = widget.clTeam;
      outcome = widget.outcome;
      resultedInFormalReferral = widget.resultedInFormalReferral;
      comments = widget.comments;
      _isLoading = false;
      print(widget.startTime);
      print(widget.startDate);
      print(widget.sessionDuration);
      print(widget.referralMode);
      print(widget.referralSource);
      print(widget.dob);
      print(widget.urn);
      print(widget.gender);
      print(widget.clTeam);
      print(widget.outcome);
      print(widget.resultedInFormalReferral);
      print(widget.comments);

      noOfDoctorTextFields = widget.doctorName.length;
      noOfPosDropDowns = widget.posCode.length;
      print(noOfPosDropDowns);
      print(noOfDoctorTextFields);
      savedDate = widget.startDate;
      Savedtime = widget.startTime;
      for (int j = 0; j < widget.posCode.length; j++) {
        List<String> temp = [];
        temp.add(widget.posCode[j].values.toList()[0].toString());
        temp.add(widget.posCode[j].values.toList()[1].toString());
        posCode.add(temp);
      }
      print(posCode);
      for (int j = 0; j < widget.doctorName.length; j++) {
        List<String> temp = [];
        temp.add(widget.doctorName[j].values.toList()[1].toString());
        temp.add(widget.doctorName[j].values.toList()[0].toString());
        // print(widget.doctorName[j].values[0]);
        doctorName.add(temp);
      }
      print(doctorName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _doctorNameController = TextEditingController();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          AbsorbPointer(
            absorbing: _isLoading,
            child: Container(
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
                            padding: EdgeInsets.only(
                                left: w * 0.035, right: w * 0.035),
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
                                      Icons.cancel_rounded,
                                      size: w * 0.08,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
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
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.06),
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
                              TimeOfDay timePicked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              TimeOfDay _selectedTime;
                              if (timePicked != null) {
                                setState(() {
                                  _selectedTime = timePicked;
                                });
                                DateTime tempDate = DateFormat("hh:mm").parse(
                                    _selectedTime.hour.toString() +
                                        ":" +
                                        _selectedTime.minute.toString());
                                var dateFormat = DateFormat("h:mm a");
                                startTime = dateFormat.format(tempDate);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.035),
                          child: Text(
                            'Clinicians',
                            style: TextStyle(
                                color: Colors.black, fontSize: w * 0.06),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
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
                        ElevatedButton(
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
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.04),
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
                        initialValue: urn,
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
                        ElevatedButton(
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
                        ElevatedButton(
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
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.035),
                      child: Text(
                        "Total time duration: " +
                            (sessionDuration ?? "0") +
                            " minutes",
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.045),
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
                        initialValue: comments,
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
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        child: Container(
                            height: h * 0.05,
                            width: w * 0.9,
                            decoration: BoxDecoration(
                                color: HexColor('#485e43'),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white, fontSize: h * 0.03),
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
                          //     clTeam +
                          //     ' ' +
                          //     posCode.toString() +
                          //     ' ' +
                          //     outcome +
                          //     ' ' +
                          //     resultedInFormalReferral +
                          //     ' ' +
                          //     comments);
                          bool isempty = false;
                          if (startDate == '___________' ||
                              startTime == '___________' ||
                              dob == '___________' ||
                              comments == '' ||
                              comments == null ||
                              urn == '' ||
                              urn == null) {
                            isempty = true;
                          }
                          for (int c = 0; c < doctorName.length; c++) {
                            if (doctorName[c][0] == '') {
                              isempty = true;
                            }
                          }
                          for (int c = 0; c < posCode.length; c++) {
                            if (posCode[c][1] == '') {
                              isempty = true;
                            }
                          }
                          if (isempty == true) {
                            showAlertDialog(context);
                          } else {
                            showConfirmDialog(context);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void calculateTotalTime() {
    int totaltime = 0;
    for (int c = 0; c < posCode.length; c++) {
      if (posCode[c][1].isNotEmpty) {
        totaltime += int.parse(posCode[c][1]);
      }
    }
    setState(() {
      sessionDuration = totaltime.toString();
    });
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
            initialValue: doctorName[index][0],
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
                initialValue: posCode[index][1],
                onChanged: (value) {
                  setState(() {
                    posCode[index][1] = value;
                    calculateTotalTime();
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

  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget confirmButton = TextButton(
      style: TextButton.styleFrom(
          backgroundColor: HexColor('#485e43'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      child: Text(
        "Confirm",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        Navigator.pop(context);
        setState(() {
          _isLoading = true;
        });
        var ans = '';
        if (widget.check == 1) {
          ans = await editDetails();
        } else {
          ans = await uploadDetails();
        }
        print(ans);
        showSnackBar(ans);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String username = prefs.getString('POS_email');
        print(username);
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      username: username,
                    )));
      },
    );

    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: HexColor('#485e43')),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      buttonPadding: EdgeInsets.only(right: 50),
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text("Confirm"),
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Start date: " + startDate),
              Text("Start time: " + startTime),
              Text("\nDoctors: "),
              for (int index = 0; index < doctorName.length; index++)
                Text((index + 1).toString() +
                    ". Doctor: " +
                    doctorName[index][0] +
                    '\n' +
                    ((index + 1).toString() +
                        '. Discipline: ' +
                        doctorName[index][1])),
              Text("\n"),
              Text("Referral source: " + referralSource),
              Text("Referral mode: " + referralMode),
              Text("Date of birth: " + dob),
              Text("URN: " + urn),
              Text("Gender: " + gender),
              Text("CL Team: " + clTeam),
              Text("\nInterventions: "),
              for (int index = 0; index < posCode.length; index++)
                Text((index + 1).toString() +
                    ". Intervention: " +
                    posCode[index][0] +
                    '\n' +
                    ((index + 1).toString() +
                        '. Time: ' +
                        posCode[index][1])),
              Text("\n"),
              Text("Total time: " + sessionDuration),
              Text("Outcome: " + outcome),
              Text("Resulted in formal referral: " + resultedInFormalReferral),
              Text("Comments: " + comments)
            ],
          ),
        ),
      ),
      actions: [cancelButton, confirmButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(color: Colors.green),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    title: Text("Error"),
    content: Text("Please fill out all the details"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
