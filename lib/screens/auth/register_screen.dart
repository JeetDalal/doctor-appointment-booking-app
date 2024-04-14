import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_reminder/screens/auth/login_screen.dart';
// import 'package:stock_reminder/screens/login_screen.dart';
import 'package:stock_reminder/services/auth_service.dart';
import 'package:stock_reminder/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();

  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 25, right: 25, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign in to your\nAccount",
              style:
                  GoogleFonts.barlow(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to HealthPal",
              style: GoogleFonts.barlow(
                  fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              errorMessage ?? "",
              style: GoogleFonts.inter(color: Colors.red),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your Name",
              style: GoogleFonts.barlow(fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _name,
                cursorColor: primaryButtonColor,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Your Email",
              style: GoogleFonts.barlow(fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _email,
                cursorColor: primaryButtonColor,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Password",
              style: GoogleFonts.barlow(fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _password,
                obscureText: true,
                cursorColor: primaryButtonColor,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                final message = await AuthService()
                    .registerUser(_email.text, _password.text, _name.text);
                if (message.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Registration was successful")));
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                } else {
                  setState(() {
                    errorMessage = message;
                  });
                  log(message);
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryButtonColor,
                  borderRadius: primaryButtonBorderRadius,
                ),
                child: Center(
                  child: Text(
                    "Register",
                    style:
                        GoogleFonts.barlow(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("I have an account ? "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.barlow(
                      color: primaryButtonColor,
                      fontWeight: FontWeight.bold,
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
