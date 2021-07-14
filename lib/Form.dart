import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

String username = 'Soham';
String startDate = '___________';
String startTime = '___________';
String participationDropDownChoice = 'Consumer did not participate';
String deliveryDropDownChoice = 'Other';
String clinicianName = 'Soham';
String travelTo = '___________';
String travelFrom = '___________';
String prepAndDoc = '___________';
String deliveryDropDownChoice2 = 'Please Select';
String delivery3 = '';
String consumerName = '';
String consumerEncounter = '';

List<String> participationDropDown = [
  'Consumer did not participate',
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4'
];

List<String> deliveryDropDown = [
  'Other',
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4'
];

List<String> delivery2DropDown = [
  'Please Select',
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4'
];

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    var _cliniciansNameController = TextEditingController();
    var _consumerNameController = TextEditingController();
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
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Start Date and Time',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
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
              SizedBox(
                height: h * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Participation',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
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
                    value: participationDropDownChoice,
                    onChanged: (value) {
                      setState(() {
                        participationDropDownChoice = value;
                      });
                    },
                    items: participationDropDown.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Delivery',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
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
                    value: deliveryDropDownChoice,
                    onChanged: (value) {
                      setState(() {
                        deliveryDropDownChoice = value;
                      });
                    },
                    items: deliveryDropDown.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Clinicians',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.06),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Name',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      clinicianName = value;
                    });
                  },
                  controller: _cliniciansNameController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _cliniciansNameController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      hintText: 'Enter your name'),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Delivery',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
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
                    value: deliveryDropDownChoice2,
                    onChanged: (value) {
                      setState(() {
                        deliveryDropDownChoice2 = value;
                      });
                    },
                    items: delivery2DropDown.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Travel to',
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.05),
                      ),
                      TextButton(
                        child: Text(
                          travelTo,
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
                              travelTo = _timeOfDay.format(context);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Travel from',
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.05),
                      ),
                      TextButton(
                        child: Text(
                          travelFrom,
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
                              travelFrom = _timeOfDay.format(context);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Prep & Doc',
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.05),
                      ),
                      TextButton(
                        child: Text(
                          prepAndDoc,
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
                              prepAndDoc = _timeOfDay.format(context);
                            });
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Delivery',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              SizedBox(height: h * 0.015),
              Padding(
                padding: EdgeInsets.only(left: w * 0.06, right: 30),
                child: Container(
                  width: w * 0.9,
                  height: h * 0.055,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              delivery3 = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter the Clinicians',
                              border: InputBorder.none),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: VerticalDivider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Icon(Icons.more_horiz),
                      SizedBox(
                        width: w * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Consumer',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.06),
                ),
              ),
              SizedBox(height: h * 0.015),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Name',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      consumerName = value;
                    });
                  },
                  controller: _consumerNameController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _consumerNameController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      hintText: 'Enter your name'),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035),
                child: Text(
                  'Encounter',
                  style: TextStyle(color: Colors.black, fontSize: w * 0.05),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.035, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      clinicianName = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Episode'),
                ),
              ),
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormPage()));
                  },
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
