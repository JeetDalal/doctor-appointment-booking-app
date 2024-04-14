import 'package:flutter/material.dart';
import 'package:stock_reminder/utils/constants.dart';

class AppBottomNavBar extends StatefulWidget {
  final PageController controller;
  const AppBottomNavBar({required this.controller, super.key});

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (val) {
        setState(() {
          index = val;
        });
        widget.controller.animateToPage(index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInExpo);
      },
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryButtonColor,
      unselectedItemColor: Colors.grey,
      enableFeedback: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            // color: Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_on_outlined,
            // color: Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month_outlined,
            // color: Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outlined,
            // color: Colors.grey,
          ),
          label: '',
        ),
      ],
    );
  }
}
