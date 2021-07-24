import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pos/Form.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo',
      home: HomePage(),);
  }
}

/// The hove page which hosts the calendar
class HomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String finalDate = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add , color: Colors.white,),
            backgroundColor: Colors.green,
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormPage()));
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h/5,
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User' ,),
                            SizedBox(
                              height: h/150,
                            ),
                            Text('GURURAJAN' , style: TextStyle(
                              fontSize: h/40,
                              color: HexColor('#c1e4ba'),
                              fontWeight: FontWeight.w400,
                            ),),
                            SizedBox(
                              height: h/50,
                            ),
                            Text("Date"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 15 , right: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: HexColor('#c1e4ba'))
                                  ),
                                  child: Text(DateTime.parse(finalDate).day.toString()+' / '+DateTime.parse(finalDate).month.toString()+' / '+DateTime.parse(finalDate).year.toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: h/35
                                    ),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.filter_list_alt, color: HexColor('#c1e4ba'),), splashColor: HexColor('#c1e4ba'),),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.view_list, color: HexColor('#c1e4ba'),)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      height: 100,
                      width: w,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.lightGreenAccent,
                                width: 0.75,
                              )
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: MeetingDataSource(_getDataSource()),
                  cellBorderColor: Colors.lightGreenAccent,
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                ),
              ),
            ],
          )),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final String subject = "There is a conf today";
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'Conference', startTime.add(const Duration(hours: 2)), endTime.add(const Duration(hours: 2)), const Color(0xFF0F8644), false));
    return meetings;
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
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

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
}
