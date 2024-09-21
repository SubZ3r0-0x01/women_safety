// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:women_safety/widgets/custom_appbar.dart';
// import 'package:women_safety/widgets/custom_button.dart';
// import 'package:women_safety/screens/sign_in-sign_up/signup_screen.dart';
//
// class DocVerificationScreen extends StatefulWidget {
//   const DocVerificationScreen({super.key});
//
//   @override
//   State<DocVerificationScreen> createState() => _DocVerificationScreenState();
// }
//
// class _DocVerificationScreenState extends State<DocVerificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => SignupScreen()));
//         },
//         text: 'Register',
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Personal Documents',
//                 style: GoogleFonts.urbanist(
//                     textStyle: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     )),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Link your Digilocker account to upload your personal document securely.',
//                 style: GoogleFonts.urbanist(
//                     textStyle: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     )),
//               ),
//               SizedBox(height: 40),
//               TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Aadhaar Card",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   )),
//               SizedBox(height: 760),
//               CustomButton(text: 'Verify with Digilocker', onPressed: () {}),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
