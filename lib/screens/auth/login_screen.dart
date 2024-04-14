import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_reminder/screens/auth/register_screen.dart';
import 'package:stock_reminder/screens/controller/constroller_screen.dart';
import 'package:stock_reminder/screens/home/home_screen.dart';
// import '../../images/home_screen.dart';

import 'package:stock_reminder/services/auth_service.dart';
import 'package:stock_reminder/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 130, left: 25, right: 25, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/Vector.png'),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Health",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                  ),
                ),
                Text(
                  "Pal",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff111928),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Hi, Welcome Back!",
              style: GoogleFonts.inter(
                  color: const Color(0xff1C2A3A),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Hope you're doing fine.",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Color(0xff6B7280),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              errorMessage ?? "",
              style: GoogleFonts.inter(color: Colors.red),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _email,
                cursorColor: primaryButtonColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Your Email',
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
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _password,
                obscureText: true,
                cursorColor: primaryButtonColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'Your Password',
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
            GestureDetector(
              onTap: () async {
                String message =
                    await AuthService().signInUser(_email.text, _password.text);
                if (message.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User Signed in Successfully!")));
                  Navigator.of(context).pushReplacementNamed(
                      ScreenNavigationController.routeName);
                } else {
                  setState(() {
                    errorMessage = message;
                  });
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
                    "Sign in",
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "or login with account",
                style: GoogleFonts.inter(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 8, left: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.network(
                          "https://i.pinimg.com/736x/2d/69/10/2d69108bd4c046bba683589b106a5dd3.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Continue with Google",
                        style: GoogleFonts.inter(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 8, left: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "images/_Facebook.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "  Continue with Facebook",
                        style: GoogleFonts.inter(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(),
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.inter(
                    color: primaryLinkColor, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("I don't have an account ? "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text(
                    "Register",
                    style: GoogleFonts.inter(
                      color: primaryLinkColor,
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
