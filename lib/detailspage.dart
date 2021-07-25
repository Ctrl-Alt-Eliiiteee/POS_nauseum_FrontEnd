import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

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

class Details extends StatefulWidget {
  final String username;
  final String startDate;
  final String startTime;
  final String sessionDuration;
  final String doctorName;
  final String referralSource;
  final String referralMode;
  final String dob;
  final String urn;
  final String gender;
  final String discipline;
  final String clTeam;
  final String posCode;
  final String outcome;
  final String resultedInFormalReferral;
  final String comments;

  const Details(
      {Key key,
      this.username,
      this.startDate,
      this.startTime,
      this.sessionDuration,
      this.doctorName,
      this.referralSource,
      this.referralMode,
      this.dob,
      this.urn,
      this.gender,
      this.discipline,
      this.clTeam,
      this.posCode,
      this.outcome,
      this.resultedInFormalReferral,
      this.comments})
      : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void iniState() {
    super.initState();
    print(widget.comments);
    print(widget.resultedInFormalReferral);
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
                            const TextSpan(
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
              AbsorbPointer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


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
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        label: Text(
                          widget.startDate,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {},
                      ),
                      TextButton.icon(
                        icon: const Icon(
                          Icons.timer,
                          color: Colors.black,
                        ),
                        label: Text(
                          widget.startTime,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () async {},
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
                    icon: const Icon(
                      Icons.timer,
                      color: Colors.black,
                    ),
                    label: Text(
                      widget.sessionDuration,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () async {},
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
                    minLines: null,
                    maxLines: null,
                    initialValue: widget.doctorName,
                    decoration:
                        const InputDecoration(hintText: 'Enter name(s)'),
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
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    label: Text(
                      widget.dob,
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
                      if (_dateTime != null) {}
                    },
                  ),
                ),
                SizedBox(height: h * 0.02),
                customText(h, w, 'URN'),
                SizedBox(height: h * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.035, right: 20),
                  child: TextFormField(
                    initialValue: widget.urn,
                    onChanged: (value) {},
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
                customText(h, w, 'Comments'),
                SizedBox(height: h * 0.015),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.035, right: 20),
                  child: TextFormField(
                    minLines: null,
                    maxLines: null,
                    initialValue: widget.comments.toString(),
                    decoration: const InputDecoration(hintText: 'Comments'),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                const SizedBox(height: 100)
                  ],
                ),
              ),
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
            border: Border.all(color: Colors.grey)),
        child: DropdownButton(
          underline: SizedBox(),
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            color: HexColor('#82cb70'),
          ),
          isExpanded: true,
          iconSize: w * 0.07,
          value: (index == 0)
              ? widget.referralSource
              : (index == 1)
                  ? widget.referralMode
                  : (index == 2)
                      ? widget.gender
                      : (index == 3)
                          ? widget.discipline
                          : (index == 4)
                              ? widget.clTeam
                              : (index == 5)
                                  ? widget.posCode
                                  : (index == 6)
                                      ? widget.outcome
                                      : widget.resultedInFormalReferral,
          onChanged: (v) {},
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
}