// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety/auth/forgot_password.dart';
import 'package:women_safety/screens/home/general_home_screen.dart';
import 'package:women_safety/widgets/custom_appbar.dart';
import 'package:women_safety/widgets/custom_button.dart';
import 'package:women_safety/screens/onboarding/onboarding_screen.dart';
import 'package:women_safety/screens/sign_in-sign_up/signup_screen.dart';
import 'package:women_safety/screens/sign_in-sign_up/otp_verification_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isPasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
        }, text: 'Login',
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Welcome!",
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Login to Stay Safe and Connected.",
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText:
                  !isPasswordShown, // Use the variable to control visibility
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordShown =
                          !isPasswordShown; // Toggle the visibility
                    });
                  },
                  icon: isPasswordShown
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              validator: (password) {
                if (password!.isEmpty || password.length < 8) {
                  return 'enter correct password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForgotPassword()));
                    },
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 14),
                    )))),
            SizedBox(height: 20),
            CustomButton(
                text: "Login",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeneralHomeScreen()));
                },
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New User? ", style: GoogleFonts.urbanist()),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                  },
                  child: Text(
                    "Register Now",
                    style: GoogleFonts.urbanist(textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "OR",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            buildSocialButton(
              "Sign in with Google",
              "assets/icons/google-icon.svg", // Replace with Google icon asset path
              Colors.white,
              Colors.black,
            ),
            SizedBox(height: 10),
            buildSocialButton(
              "Sign in with Apple ID",
              "assets/icons/apple-icon.svg", // Replace with Apple icon asset path
              Colors.white,
              Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSocialButton(
      String text, String iconPath, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: SvgPicture.asset(
          iconPath,
          height: 24,
        ),
        label: Text(
          text,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: bgColor,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // Add your social login functionality here
        },
      ),
    );
  }
}
