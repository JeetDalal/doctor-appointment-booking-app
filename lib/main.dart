import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_reminder/screens/auth/login_screen.dart';
import 'package:stock_reminder/screens/auth/register_screen.dart';
import 'package:stock_reminder/screens/doctors/doctor_details_screen.dart';
import 'package:stock_reminder/screens/doctors/doctors_screen.dart';
import 'package:stock_reminder/screens/home/home_screen.dart';
// import '../images/home_screen.dart';
import 'package:stock_reminder/screens/home/widgets/add_investment.dart';
import 'package:stock_reminder/screens/location/update_location_screen.dart';
// import 'package:stock_reminder/screens/login_screen.dart';
import 'package:stock_reminder/screens/onboarding/on_boarding_screen.dart';
// import 'package:stock_reminder/screens/register_screen.dart';
import 'package:stock_reminder/services/auth_service.dart';
import 'package:stock_reminder/services/location_service.dart';
import 'package:stock_reminder/services/provider_services.dart';

import 'screens/controller/constroller_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAcAHMHor2kjMIeQmIEHXaTI0fW2Dti2Gk',
    appId: '1:95313598913:ios:ab90bb33804cedee64f740',
    messagingSenderId: '95313598913',
    projectId: 'down-syndrome-63b13',
  ));
  runApp(const PaymentsTracker());
}

class PaymentsTracker extends StatelessWidget {
  const PaymentsTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationService(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonColor: const Color(0xff1C2A3A),
        ),
        home: AuthService().currentUser != null
            ? ScreenNavigationController()
            : OnboardingScreen(),
        routes: {
          UserLocationScreen.routeName: (context) => const UserLocationScreen(),
          ScreenNavigationController.routeName: (context) =>
              const ScreenNavigationController(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddInvestmentWidget.routeName: (context) =>
              const AddInvestmentWidget(),
          DoctorScreen.routeName: (context) => DoctorScreen(),
          DoctorDetailsScreen.routeName: (context) => DoctorDetailsScreen(),
        },
      ),
    );
  }
}
