import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Form.dart';
import 'package:pos/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'helperfunctions.dart';
import 'package:intl/intl.dart';

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar Demo',
      home: HomePage(),
    );
  }
}

var _loadDetailsFromFirebase;
List<Meeting> meetings = <Meeting>[];

/// The hove page which hosts the calendar
class HomePage extends StatefulWidget {
  final String username;

  /// Creates the home page to display teh calendar widget.
  const HomePage({Key key, this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  String finalDate = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormPage(
                            username: widget.username
                                .substring(0, widget.username.indexOf('@')),
                            check: 0,
                          )));
            },
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //height: h / 5,
                    padding: EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User',
                            ),
                            SizedBox(
                              height: h / 150,
                            ),
                            Text(
                              widget.username
                                  .substring(0, widget.username.indexOf('@')),
                              style: TextStyle(
                                fontSize: h / 40,
                                color: Colors.green,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            Text("Date"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: HexColor('#c1e4ba'))),
                                  child: Text(
                                    DateTime.parse(finalDate).day.toString() +
                                        ' / ' +
                                        DateTime.parse(finalDate)
                                            .month
                                            .toString() +
                                        ' / ' +
                                        DateTime.parse(finalDate)
                                            .year
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.green, fontSize: h / 35),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     // Icons.filter_list_alt,
                                    //     color: HexColor('#c1e4ba'),
                                    //   ),
                                    //   splashColor: HexColor('#c1e4ba'),
                                    // ),
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: Icon(
                                    //       Icons.view_list,
                                    //       color: HexColor('#c1e4ba'),
                                    //     )),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.green),
                        ));
                      } else {
                        return Expanded(
                          child: SfCalendar(
                            view: CalendarView.month,
                            dataSource: MeetingDataSource(_getDataSource()),
                            cellBorderColor: Colors.lightGreenAccent,
                            monthViewSettings: const MonthViewSettings(
                                appointmentDisplayMode:
                                    MonthAppointmentDisplayMode.appointment),
                            onLongPress: (value) {
                              print(value.date);
                              showMeetings(value.date);
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      showMeetings(value.date));
                            },
                          ),
                        );
                      }
                    },
                    future: _loadDetails(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('POS_email', '');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    icon: Icon(
                      Icons.logout,
                      color: HexColor('#c1e4ba'),
                    ),
                    splashColor: HexColor('#c1e4ba'),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<String> _loadDetails() async {
    _loadDetailsFromFirebase = await getdetails();
    if (_loadDetailsFromFirebase.length == 0) {
      return "DONE";
    }
    return _loadDetailsFromFirebase[0].startDate;
  }

  Widget showMeetings(DateTime selectedDate) {
    List<Meeting> meetingsFromSelectedDate = <Meeting>[];
    for (int c = 0; c < meetings.length; c++) {
      if (meetings[c].from == selectedDate) {
        meetingsFromSelectedDate.add(meetings[c]);
      }
    }
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (meetingsFromSelectedDate.length == 0) {
      return Container(
        width: w,
        height: h / 2,
        child: Center(
          child: Text(
              "No meetings schduled for " +
                  selectedDate.day.toString() +
                  '/' +
                  selectedDate.month.toString() +
                  '/' +
                  selectedDate.year.toString(),
              style: TextStyle(color: Colors.black, fontSize: w * 0.05)),
        ),
      );
    }

    return Container(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text(
                "Meetings schduled for " +
                    selectedDate.day.toString() +
                    '/' +
                    selectedDate.month.toString() +
                    '/' +
                    selectedDate.year.toString(),
                style: TextStyle(color: Colors.black, fontSize: w * 0.05)),
          ),
          for (int c = 0; c < meetingsFromSelectedDate.length; c++)
            Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        padding: EdgeInsets.all(0)),
                    onPressed: () {
                      print(meetingsFromSelectedDate[c].doctorNames.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormPage(
                                    username: widget.username.substring(
                                        0, widget.username.indexOf('@')),
                                    check: 1,
                                    startDate:
                                        meetingsFromSelectedDate[c].startDate,
                                    startTime:
                                        meetingsFromSelectedDate[c].startTime,
                                    sessionDuration: meetingsFromSelectedDate[c]
                                        .sessionDuration,
                                    doctorName:
                                        meetingsFromSelectedDate[c].doctorNames,
                                    referralSource: meetingsFromSelectedDate[c]
                                        .referralSource,
                                    referralMode: meetingsFromSelectedDate[c]
                                        .referralMode,
                                    dob: meetingsFromSelectedDate[c].dob,
                                    urn: meetingsFromSelectedDate[c].urn,
                                    gender: meetingsFromSelectedDate[c].gender,
                                    clTeam: meetingsFromSelectedDate[c].clTeam,
                                    posCode:
                                        meetingsFromSelectedDate[c].posCode,
                                    outcome:
                                        meetingsFromSelectedDate[c].outcome,
                                    resultedInFormalReferral:
                                        meetingsFromSelectedDate[c]
                                            .restuledInFormalReferral,
                                    comments:
                                        meetingsFromSelectedDate[c].comments,
                                    //           .sessionDuration ,)
                                    // builder: (context) => Details(
                                    //       username: widget.username.substring(
                                    //           0, widget.username.indexOf('@')),
                                    //       startDate:
                                    //           meetingsFromSelectedDate[c].startDate,
                                    //       startTime:
                                    //           meetingsFromSelectedDate[c].startTime,
                                    //       sessionDuration: meetingsFromSelectedDate[c]
                                    //           .sessionDuration,
                                    //       doctorName:
                                    //           meetingsFromSelectedDate[c].eventName,
                                    //       referralSource: meetingsFromSelectedDate[c]
                                    //           .referralSource,
                                    //       referralMode: meetingsFromSelectedDate[c]
                                    //           .referralMode,
                                    //       dob: meetingsFromSelectedDate[c].dob,
                                    //       urn: meetingsFromSelectedDate[c].urn,
                                    //       gender: meetingsFromSelectedDate[c].gender,
                                    //       clTeam: meetingsFromSelectedDate[c].clTeam,
                                    //       posCode:
                                    //           meetingsFromSelectedDate[c].posCode,
                                    //       outcome:
                                    //           meetingsFromSelectedDate[c].outcome,
                                    //       resultedInFormalReferral:
                                    //           meetingsFromSelectedDate[c]
                                    //               .restuledInFormalReferral,
                                    //       comments:
                                    //           meetingsFromSelectedDate[c].comments,
                                    //     )
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: w - 20,
                      decoration: BoxDecoration(
                          color: HexColor('#c1e4ba'),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Text(
                            meetingsFromSelectedDate[c].eventName,
                            style: TextStyle(
                                color: Colors.black, fontSize: w * 0.05),
                          ),
                          Text(
                            meetingsFromSelectedDate[c].startTime,
                            style: TextStyle(
                                color: Colors.black, fontSize: w * 0.04),
                          ),
                          Text(
                            "Click here for more Details",
                            style: TextStyle(
                                color: Colors.black, fontSize: w * 0.035),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          SizedBox(height: 30),
        ],
      ),
    ));
  }
}

List<Meeting> _getDataSource() {
  meetings = <Meeting>[];
  for (int c = 0; c < _loadDetailsFromFirebase.length; c++) {
    final DateTime startTime =
        DateFormat('d/M/yyyy').parse(_loadDetailsFromFirebase[c].startDate);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        _loadDetailsFromFirebase[c].doctorNames[0].values.toList()[1],
        startTime,
        endTime,
        const Color(0xFF0F8644),
        true,
        _loadDetailsFromFirebase[c].startDate,
        _loadDetailsFromFirebase[c].startTime,
        _loadDetailsFromFirebase[c].sessionDuration,
        _loadDetailsFromFirebase[c].doctorNames,
        _loadDetailsFromFirebase[c].referralSource,
        _loadDetailsFromFirebase[c].referralMode,
        _loadDetailsFromFirebase[c].dob,
        _loadDetailsFromFirebase[c].urn,
        _loadDetailsFromFirebase[c].gender,
        _loadDetailsFromFirebase[c].clTeam,
        _loadDetailsFromFirebase[c].poscode,
        _loadDetailsFromFirebase[c].outcome,
        _loadDetailsFromFirebase[c].restuledInFormalReferral,
        _loadDetailsFromFirebase[c].comments));
  }
  return meetings;
}

class CalendarDayView extends StatefulWidget {
  final DateTime dateTime;

  const CalendarDayView({Key key, this.dateTime}) : super(key: key);
  @override
  _CalendarDayViewState createState() => _CalendarDayViewState();
}

class _CalendarDayViewState extends State<CalendarDayView> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.day,
      initialDisplayDate: widget.dateTime,
      dataSource: MeetingDataSource(_getDataSource()),
      cellBorderColor: Colors.lightGreenAccent,
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      onLongPress: (value) {},
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments[index];
    Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
      this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.startDate,
      this.startTime,
      this.sessionDuration,
      this.doctorNames,
      this.referralSource,
      this.referralMode,
      this.dob,
      this.urn,
      this.gender,
      this.clTeam,
      this.posCode,
      this.outcome,
      this.restuledInFormalReferral,
      this.comments);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  String startDate;
  String startTime;
  String sessionDuration;
  List doctorNames = [];
  String referralSource;
  String referralMode;
  String dob;
  String urn;
  String gender;
  // String discipline;
  String clTeam;
  List posCode = [];
  String outcome;
  String restuledInFormalReferral;
  String comments;
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
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
