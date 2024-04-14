import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:stock_reminder/screens/login_screen.dart';

import '../auth/login_screen.dart';
import 'on_boarding_screen_item.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int wildIndex = 0;
  // Timer _timer = Timer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      log(wildIndex.toString());
      setState(() {
        if (wildIndex == 2) {
          wildIndex = 0;
        } else {
          wildIndex++;
        }
        _pageController.animateToPage(wildIndex,
            duration: const Duration(
              milliseconds: 500,
            ),
            curve: Curves.easeInOut);
      });
    });
  }

  PageController _pageController = PageController();

  final List<OnboardingScreenItem> _screens = const [
    OnboardingScreenItem(
      title: "Meet Doctors Online",
      subtitle:
          "Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.",
      imageUrl: "images/doc1.png",
    ),
    OnboardingScreenItem(
      title: "Connect with Specialists",
      subtitle:
          "Discover a vast network of doctors and hospitals in your area. Whether you need a specialist or urgent care, HealthConnect makes it simple to find the right healthcare provider closest to you.",
      imageUrl: "images/doc2.png",
    ),
    OnboardingScreenItem(
      title: "Manage Your Health",
      subtitle:
          "Take control of your health with HealthConnect's intuitive features. Schedule appointments, set reminders, and access your medical records seamlessly. Your health, your way, all in one app.",
      imageUrl: "images/doc3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: PageView.builder(
                controller: _pageController,
                itemCount: _screens.length,
                itemBuilder: (context, index) {
                  return _screens[index];
                }),
          ),
          Positioned(
            bottom: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Container(
                    height: 50,
                    width: 311,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          "Get started",
                          style: GoogleFonts.barlow(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _screens.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    offset: 16,
                    activeDotColor: Colors.black,
                    // dotWidth: 50,
                    // strokeWidth: 0.5,
                    dotColor: const Color(0xff9B9B9B),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    'skip',
                    style: GoogleFonts.inter(color: const Color(0xff6B7280)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
