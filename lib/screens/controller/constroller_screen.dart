import 'package:flutter/material.dart';
import 'package:stock_reminder/screens/appointments/appointments_screen.dart';
import 'package:stock_reminder/screens/profile/profile_screen.dart';
import 'package:stock_reminder/screens/location/location_screen.dart';
// import '../../../images/home_screen.dart';

import '../home/home_screen.dart';
import 'bottom_nav_bar.dart';

class ScreenNavigationController extends StatefulWidget {
  const ScreenNavigationController({super.key});

  @override
  State<ScreenNavigationController> createState() =>
      _ScreenNavigationControllerState();

  static const routeName = '/screen-controller';
}

class _ScreenNavigationControllerState
    extends State<ScreenNavigationController> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(
        controller: _controller,
      ),
      body: PageView(
        controller: _controller,
        children: [
          HomeScreen(),
          LocationScreen(),
          AppointmentScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
