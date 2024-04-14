import 'package:flutter/material.dart';

import 'upcoming_appointments_widget.dart';

class CompletedAppointmentsWidget extends StatelessWidget {
  const CompletedAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Container(),
            );
          },
        ),
      ),
    );
  }
}
