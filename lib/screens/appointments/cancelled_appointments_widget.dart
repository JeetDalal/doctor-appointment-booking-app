import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/appointment_services.dart';
import '../../utils/constants.dart';
import 'upcoming_appointments_widget.dart';

class CancelledAppointmentWidget extends StatefulWidget {
  const CancelledAppointmentWidget({super.key});

  @override
  State<CancelledAppointmentWidget> createState() =>
      _CancelledAppointmentWidgetState();
}

class _CancelledAppointmentWidgetState
    extends State<CancelledAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: AppointmentServices().appointmentCluster.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data() == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: primaryButtonColor,
                    size: 80,
                  ),
                  Text(
                    "No cancelled appointments!",
                    style: GoogleFonts.inter(
                      color: primaryButtonColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            }
            final upcomingAppointmentsList = (snapshot.data!.data()
                as Map<String, dynamic>)['cancelled'] as List<dynamic>;

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: upcomingAppointmentsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: AppointmentCard(
                      isCancelled: true,
                      docId: upcomingAppointmentsList[index]['docId'],
                      date: upcomingAppointmentsList[index]['date'],
                      time: upcomingAppointmentsList[index]['time'],
                      imageUrl: upcomingAppointmentsList[index]['imageUrl'],
                      location: upcomingAppointmentsList[index]['location'],
                      name: upcomingAppointmentsList[index]['docName'],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryButtonColor,
              ),
            );
          }
        });
  }
}
