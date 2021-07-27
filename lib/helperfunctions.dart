import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/Form.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> uploadDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('POS_email');
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
      'Name of Doctors': doctorName,
      'Referral Source': referralSource,
      'Referral Mode': referralMode,
      'DOB': dob,
      'URN': urn,
      'Gender': gender,
      //'Discipline': discipline,
      'CL Team': clTeam,
      'POS Code': posCode,
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
        String startDate = result.data()['Start Date'];
        String starttime = result.data()['Start Time'];
        String sessionDuration = result.data()['Duration'];
        String doctorName = result.data()['Name of Doctors'];
        String referralSource = result.data()['Referral Source'];
        String referralmode = result.data()['Referral Mode'];
        String dob = result.data()['DOB'];
        String urn = result.data()['URN'];
        String gender = result.data()['Gender'];
        String discipline = result.data()['Discipline'];
        String clteam = result.data()['CL Team'];
        String posCode = result.data()['POS Code'];
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
            discipline: discipline,
            clTeam: clteam,
            posCode: posCode,
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
      doctorNames,
      referralSource,
      referralMode,
      dob,
      urn,
      gender,
      discipline,
      clTeam,
      posCode,
      outcome,
      restuledInFormalReferral,
      comments;

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
      this.discipline,
      this.clTeam,
      this.posCode,
      this.outcome,
      this.restuledInFormalReferral,
      this.comments});
}
