import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreenItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  const OnboardingScreenItem(
      {required this.title,
      required this.subtitle,
      required this.imageUrl,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imageUrl,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: const Color(0xff374151),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: const Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
