import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_reminder/screens/doctors/doctors_screen.dart';
import 'package:stock_reminder/services/auth_service.dart';

class AppointmentServices {
  final appointmentCluster = FirebaseFirestore.instance
      .collection('appointments')
      .doc(AuthService().currentUser!.uid);

  bookApointment(String date, String time, DoctorCard docDetails) async {
    final data = await appointmentCluster.get();
    if (!data.exists) {
      await appointmentCluster
          .set({"upcoming": [], "completed": [], "cancelled": []});
    }
    final updatedData = await appointmentCluster.get();
    var upcomingAppointments = ((updatedData.data()
        as Map<String, dynamic>)['upcoming']) as List<dynamic>;

    upcomingAppointments.add({
      'time': time,
      'date': date,
      'docId': docDetails.id,
      'patientId': AuthService().currentUser!.uid,
      'location': docDetails.address,
      'docName': docDetails.name,
      'imageUrl': docDetails.imageUrl,
      'specialty': docDetails.speciality,
    });

    await appointmentCluster.update({"upcoming": upcomingAppointments}).then(
        (value) => log("Data inserted successfully"));
  }

  cancelAppointment(String docId) async {
    try {
      final data = await appointmentCluster.get();
      final responseData =
          (data.data() as Map<String, dynamic>)['upcoming'] as List<dynamic>;
      final appointment =
          responseData.firstWhere((element) => element['docId'] == docId);
      responseData.removeWhere((element) => element['docId'] == docId);
      final cancelledAppointments =
          (data.data() as Map<String, dynamic>)['cancelled'] as List<dynamic>;
      cancelledAppointments.add(appointment);
      await appointmentCluster.update({
        "upcoming": responseData,
        "cancelled": cancelledAppointments
      }).then((value) => log("Appointment cancelled successfully"));
    } catch (e) {
      log(e.toString());
    }
  }
}
