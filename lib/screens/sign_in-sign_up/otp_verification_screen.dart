// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety/widgets/custom_appbar.dart';
import 'package:women_safety/widgets/custom_button.dart';
import 'package:women_safety/screens/sign_in-sign_up/signin_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId; // Pass this from ForgotPassword screen if using Firebase
  OtpVerificationScreen({super.key, required this.verificationId});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  List<String> otp = List.filled(4, '');
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Uncomment and use this function for Firebase OTP verification
  // Future<void> verifyOTP() async {
  //   String otpCode = otp.join();
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: widget.verificationId,
  //     smsCode: otpCode,
  //   );

  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     // Navigate to another screen after successful verification
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
        },
        text: 'OTP Verification',
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Please enter the One Time Password sent to your phone.",
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    textStyle: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          otp[index] = value; // Capture OTP input
                          if (index < 3) {
                            FocusScope.of(context).nextFocus();  // Move to next field
                          }
                        } else {
                          if (index > 0) {
                            otp[index] = ''; // Reset the value if backspace
                            FocusScope.of(context).previousFocus();  // Move to previous field on backspace
                          }
                        }
                      },
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '0',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not Received a code? "),
                  GestureDetector(
                    onTap: () {
                      // Resend OTP action
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Verify OTP",
                onPressed: () {
                  // Call the OTP verification logic
                  // verifyOTP();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP Verified!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
