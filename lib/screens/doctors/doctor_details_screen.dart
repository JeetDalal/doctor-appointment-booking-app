import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_reminder/screens/doctors/doctors_screen.dart';
import 'package:stock_reminder/services/appointment_services.dart';

import '../../utils/constants.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  static const routeName = '/doctor-details';

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate!) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final today = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return today.hour < 12
        ? '${timeOfDay.format(context)} '
        : '${timeOfDay.format(context)} ';
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (picked != null && picked != timeOfDay) {
      setState(() {
        timeOfDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final docDetails = ModalRoute.of(context)!.settings.arguments as DoctorCard;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Doctor details',
          style: GoogleFonts.inter(
            color: primaryButtonColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            docDetails,
            const SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: primaryButtonColor,
                          size: 40,
                        ),
                      ),
                      backgroundColor: Color(0xffF3F4F6),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '2,000+',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'patients',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        // fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: primaryButtonColor,
                          size: 40,
                        ),
                      ),
                      backgroundColor: Color(0xffF3F4F6),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '10+',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Experience',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        // fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Center(
                        child: Icon(
                          Icons.star,
                          color: primaryButtonColor,
                          size: 40,
                        ),
                      ),
                      backgroundColor: Color(0xffF3F4F6),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'rating',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        // fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Center(
                        child: Icon(
                          Icons.reviews,
                          color: primaryButtonColor,
                          size: 40,
                        ),
                      ),
                      backgroundColor: Color(0xffF3F4F6),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '185',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'reviews',
                      style: GoogleFonts.inter(
                        color: Color(0xff4B5563),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "About me",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${docDetails.name}, a dedicated ${docDetails.speciality}, brings a wealth of experience to Golden Gate Cardiology Center in Golden Gate, CA. view more",
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Working Time",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Monday-Friday, 08.00 AM-18.00 pM",
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _selectDate(context).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Date Picked successfully'),
                              ),
                            ));
                    ;
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: primaryButtonColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Select Date',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child:
                          Text(DateFormat('dd/MM/yyyy').format(selectedDate!)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _selectTime(context).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Time Picked successfully'),
                              ),
                            ));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: primaryButtonColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Select Time',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(_formatTime(timeOfDay)),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                try {
                  await AppointmentServices().bookApointment(
                      DateFormat('dd/MM/yyyy').format(selectedDate!),
                      _formatTime(timeOfDay),
                      docDetails);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Appointment Booked")));
                  Navigator.of(context).pop();
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryButtonColor,
                    borderRadius: primaryButtonBorderRadius,
                  ),
                  child: Center(
                    child: Text(
                      "Book Appointment",
                      style:
                          GoogleFonts.inter(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
