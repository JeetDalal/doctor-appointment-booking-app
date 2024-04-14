import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';

class InvestmentPlanCard extends StatelessWidget {
  const InvestmentPlanCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ABC investment",
              style:
                  GoogleFonts.barlow(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monthly Investment:",
                      style: GoogleFonts.barlow(),
                    ),
                    Text(
                      "200",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rate of return(%):",
                      style: GoogleFonts.barlow(),
                    ),
                    Text(
                      "200",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tenure in Years:",
                      style: GoogleFonts.barlow(),
                    ),
                    Text(
                      "200",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "19-10-22",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "To",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "19-10-24",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Maturity value: ",
                      style: GoogleFonts.barlow(),
                    ),
                    Text(
                      "200",
                      style: GoogleFonts.barlow(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: GoogleFonts.barlow(
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete',
                    style: GoogleFonts.barlow(
                      fontSize: 18,
                      color: Colors.red,
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
