import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_reminder/screens/appointments/cancelled_appointments_widget.dart';
import 'package:stock_reminder/screens/appointments/completed_appointment_widget.dart';
import 'package:stock_reminder/screens/appointments/upcoming_appointments_widget.dart';
import 'package:stock_reminder/utils/constants.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "My Bookings",
          style: GoogleFonts.inter(
            color: primaryButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: primaryButtonColor,
          unselectedLabelStyle: GoogleFonts.inter(
            color: primaryButtonColor,
          ),
          labelColor: primaryButtonColor,
          tabs: [
            Tab(
              text: 'Upcoming',
            ),
            // Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          UpcomingAppointmentsWidget(),
          // CompletedAppointmentsWidget(),
          CancelledAppointmentWidget()
        ],
      ),
    );
  }
}
