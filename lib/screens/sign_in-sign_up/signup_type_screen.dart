// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:women_safety/widgets/custom_appbar.dart';
// import 'package:women_safety/widgets/custom_button.dart';
// import 'package:women_safety/screens/sign_in-sign_up/signup_screen.dart';
// import 'package:women_safety/screens/sign_in-sign_up/personal_details_screen.dart';
//
// class SignupTypeScreen extends StatefulWidget {
//   const SignupTypeScreen({super.key});
//
//   @override
//   State<SignupTypeScreen> createState() => _SignupTypeScreenState();
// }
//
// class _SignupTypeScreenState extends State<SignupTypeScreen> {
//   String? _selectedUserType;
//
//   // Function for firebase connection
//   Future<void> _saveUserType(String userType) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       try {
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//           'userType': userType,
//         }, SetOptions(merge: true));
//
//         // Navigate to PersonalDetailsScreen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => PersonalDetailsScreen()),
//         );
//       } catch (e) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save user type. Please try again.')),
//         );
//       }
//     } else {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No user is currently logged in.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SignupScreen()));
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
//                 'Become a Savior – Help in Emergencies',
//                 style: GoogleFonts.urbanist(
//                     textStyle: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     )),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Your prompt action can save lives—become a savior today.',
//                 style: GoogleFonts.urbanist(
//                     textStyle: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     )),
//               ),
//               SizedBox(height: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Want to Become a Savior?',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   Row(
//                     children: [
//                       Radio<String>(
//                         value: 'Yes',
//                         groupValue: _selectedUserType,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedUserType = value;
//                           });
//                         },
//                       ),
//                       Text('Yes'),
//                       SizedBox(width: 10),
//                       Radio<String>(
//                         value: 'No',
//                         groupValue: _selectedUserType,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedUserType = value;
//                           });
//                         },
//                       ),
//                       Text('No'),
//                     ],
//                   ),
//                   SizedBox(height: 790),
//                   CustomButton(
//                     text: "Next",
//                     onPressed: () {
//                       if (_selectedUserType != null) {
//                         _saveUserType(_selectedUserType!); // Call the method to handle user type saving
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
