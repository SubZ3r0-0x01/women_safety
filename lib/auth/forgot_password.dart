import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safety/widgets/custom_appbar.dart';
import 'package:women_safety/widgets/custom_button.dart';
import 'package:women_safety/screens/sign_in-sign_up/signin_screen.dart';
import 'package:women_safety/screens/sign_in-sign_up/otp_verification_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Controller to capture phone number input
  final _phoneNumberController = TextEditingController();

  // Uncomment and use this function with your OTP provider (like Firebase)
  // Future<void> sendOTP(String phoneNumber) async {
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         // Navigate to OTP Verification Screen and pass the verification ID
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => OtpVerificationScreen(verificationId: verificationId),
  //           ),
  //         );
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
        }, text: 'Forgot Password',
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Enter your phone number.",
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: _phoneNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Add validation if necessary
            ),
            SizedBox(height: 40),
            CustomButton(
              text: 'Send OTP',
              onPressed: () {
                String phoneNumber = _phoneNumberController.text.trim();
                // Replace with actual OTP send logic
                // sendOTP(phoneNumber);

                // For now, directly navigate to OTP screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(verificationId: '',),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
