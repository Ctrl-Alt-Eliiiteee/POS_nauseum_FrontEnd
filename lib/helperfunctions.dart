import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> editDetails() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('POS_email');
  try{
    await FirebaseFirestore.instance
        .collection("Details")
        .doc(username.substring(0, username.indexOf('@')))
        .collection("Timings")
        .doc(savedDate.replaceAll("/", "-") + " " + Savedtime).delete();
    return await uploadDetails();
  }catch(e){
    return "Please Try after sometime";
  }
}
Future<String> uploadDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('POS_email');
  List ClinicanList =[];
  for(int i=0;i<doctorName.length;i++){
    ClinicanList.add({
      "Name" : doctorName[i][0],
      "Discipline" : doctorName[i][1],
    });
  }
  List PosCode =[];
  for(int i=0;i<posCode.length;i++){
    PosCode.add({
      "posCode" : posCode[i][0],
      "time" : posCode[i][1],
    });
  }
  try {
    await FirebaseFirestore.instance
        .collection("Details")
        .doc(username.substring(0, username.indexOf('@')))
        .collection("Timings")
        .doc(startDate.replaceAll("/", "-") + " " + startTime)
        .set({
      'Start Date': startDate,
      'Start Time': startTime,
      'Duration': sessionDuration,
      // 'Name of Doctors': doctorName,
      'Referral Source': referralSource,
      'Referral Mode': referralMode,
      'DOB': dob,
      'URN': urn,
      'Gender': gender,
      //'Discipline': discipline,
      "Clinicians" : FieldValue.arrayUnion(ClinicanList),
      'CL Team': clTeam,
      'POS CodeList': FieldValue.arrayUnion(PosCode),
      'Outcome': outcome,
      'Resulted in formal referral': resultedInFormalReferral,
      'Comments': comments,
    });
    return "Successfully Uploaded";
  } catch (e) {
    return username.toString();
  }
}
Future<List<object>> getdetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('POS_email');
  List<object> obj = [];
  try {
    var snap = await FirebaseFirestore.instance
        .collection("Details")
        .doc(username.substring(0, username.indexOf('@')))
        .collection("Timings")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        // List doctorName =[];
        String startDate = result.data()['Start Date'];
        String starttime = result.data()['Start Time'];
        String sessionDuration = result.data()['Duration'];
        // List.from(result.data()['Clinicians']).forEach((element) {
        //   doctorName.add({element.get('Name'),element.get('Discipline')});
        // });
         var doctorName = result.data()['Clinicians'];
        print(doctorName);
        String referralSource = result.data()['Referral Source'];
        String referralmode = result.data()['Referral Mode'];
        String dob = result.data()['DOB'];
        String urn = result.data()['URN'];
        String gender = result.data()['Gender'];
        // String discipline = result.data()['Discipline'];
        String clteam = result.data()['CL Team'];
       var posCode = result.data()['POS CodeList'];
       print(posCode);

        String outcome = result.data()['Outcome'];
        String restuledInFormalReferral =
            result.data()['Resulted in formal referral'];
        String comments = result.data()['Comments'];
        object objl = new object(
            startDate: startDate,
            startTime: starttime,
            sessionDuration: sessionDuration,
            doctorNames: doctorName,
            referralSource: referralSource,
            referralMode: referralmode,
            dob: dob,
            urn: urn,
            gender: gender,
            clTeam: clteam,
            poscode: posCode,
            outcome: outcome,
            restuledInFormalReferral: restuledInFormalReferral,
            comments: comments);
        obj.add(objl);
      });
    });
    return obj;
  } catch (e) {
    print(e);
  }
}

class object {
  String startDate,
      startTime,
      sessionDuration,

      referralSource,
      referralMode,
      dob,
      urn,
      gender,
      clTeam,
      outcome,
      restuledInFormalReferral,
      comments;
  List doctorNames=[],poscode=[];

  object(
      {this.startDate,
      this.startTime,
      this.sessionDuration,
      this.doctorNames,
      this.referralSource,
      this.referralMode,
      this.dob,
      this.urn,
      this.gender,
      this.clTeam,
      this.poscode,
      this.outcome,
      this.restuledInFormalReferral,
      this.comments});
}
