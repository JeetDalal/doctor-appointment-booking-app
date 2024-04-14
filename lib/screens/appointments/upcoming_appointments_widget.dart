import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_reminder/screens/appointments/appointments_screen.dart';
import 'package:stock_reminder/services/appointment_services.dart';
import 'package:stock_reminder/utils/constants.dart';

class UpcomingAppointmentsWidget extends StatelessWidget {
  const UpcomingAppointmentsWidget({super.key});

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
                    "No upcoming appointments!",
                    style: GoogleFonts.inter(
                      color: primaryButtonColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            } else {
              final upcomingAppointmentsList = (snapshot.data!.data()
                  as Map<String, dynamic>)['upcoming'] as List<dynamic>;

              if (upcomingAppointmentsList.isEmpty) {
                log("Empty");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: primaryButtonColor,
                      size: 80,
                    ),
                    Text(
                      "No upcoming appointments!",
                      style: GoogleFonts.inter(
                        color: primaryButtonColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: upcomingAppointmentsList.length,
                  itemBuilder: (context, index) {
                    log("Not Empty");
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: AppointmentCard(
                        isCancelled: false,
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
            }
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

class AppointmentCard extends StatelessWidget {
  final bool isCancelled;
  final String docId;
  final String name;
  final String imageUrl;
  final String time;
  final String date;
  final String location;
  const AppointmentCard({
    super.key,
    required this.isCancelled,
    required this.docId,
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$date - $time',
              style: GoogleFonts.inter(
                color: primaryButtonColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Divider(
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 109,
                  width: 109,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  $name",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryButtonColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "  Orthopedic Surgery",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4B5563),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xff4B5563),
                        ),
                        Text(
                          location,
                          style: GoogleFonts.inter(color: Color(0xff4B5563)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Divider(
                color: Colors.grey,
              ),
            ),
            isCancelled
                ? Expanded(
                    child: Container(
                      height: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffE5E7EB),
                      ),
                      child: Center(
                        child: Text(
                          'Cancelled on ${DateFormat('dd MMMM, yyyy').format(DateTime.now())}',
                          style: GoogleFonts.inter(
                            color: primaryButtonColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await AppointmentServices().cancelAppointment(docId);
                        },
                        child: Container(
                          height: 37,
                          width: 147,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffE5E7EB),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.inter(
                                color: primaryButtonColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 37,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primaryButtonColor,
                        ),
                        child: Center(
                          child: Text(
                            'Reschedule',
                            style: GoogleFonts.inter(
                              color: Color(0xffE5E7EB),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
