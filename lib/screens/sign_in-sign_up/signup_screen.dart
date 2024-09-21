// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:women_safety/widgets/custom_appbar.dart';
// import 'package:women_safety/widgets/custom_button.dart';
// import 'package:women_safety/screens/sign_in-sign_up/signin_screen.dart';
// import 'package:women_safety/screens/sign_in-sign_up/signup_type_screen.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   bool isPasswordShown = false;
//   bool isConfirmPasswordShown = false;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   bool _validatePasswords() {
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;
//
//     if (password != confirmPassword) {
//       return false;
//     }
//     return true;
//   }
//
//   // Function for firebase connection
//   Future<void> _registerUser() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;
//
//     try {
//       // Create user with email and password
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       // Navigate to SignupTypeScreen after successful registration
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => SignupTypeScreen()),
//       );
//     } catch (e) {
//       String errorMessage = "An error occurred. Please try again.";
//
//       if (e is FirebaseAuthException) {
//         switch (e.code) {
//           case 'weak-password':
//             errorMessage = 'The password provided is too weak.';
//             break;
//           case 'email-already-in-use':
//             errorMessage = 'The account already exists for that email.';
//             break;
//           case 'invalid-email':
//             errorMessage = 'The email address is invalid.';
//             break;
//           default:
//             errorMessage = 'An error occurred. Please try again.';
//             break;
//         }
//       }
//
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(errorMessage)),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SigninScreen()));
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
//                 'Basic Information',
//                 style: GoogleFonts.urbanist(
//                     textStyle: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     )),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Please provide your basic details to create your profile.',
//                 style: GoogleFonts.urbanist(
//                     textStyle: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     )),
//               ),
//               SizedBox(height: 40),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText:
//                 !isPasswordShown, // Use the variable to control visibility
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         isPasswordShown =
//                         !isPasswordShown; // Toggle the visibility
//                       });
//                     },
//                     icon: isPasswordShown
//                         ? Icon(Icons.visibility_off)
//                         : Icon(Icons.visibility),
//                   ),
//                 ),
//                 validator: (password) {
//                   if (password == null ||
//                       password.isEmpty ||
//                       password.length < 8) {
//                     return 'Enter a valid password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText:
//                 !isConfirmPasswordShown, // Use the variable to control visibility
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         isConfirmPasswordShown =
//                         !isConfirmPasswordShown; // Toggle the visibility
//                       });
//                     },
//                     icon: isConfirmPasswordShown
//                         ? Icon(Icons.visibility_off)
//                         : Icon(Icons.visibility),
//                   ),
//                 ),
//                 validator: (confirmPassword) {
//                   if (confirmPassword == null ||
//                       confirmPassword.isEmpty ||
//                       confirmPassword.length < 8) {
//                     return 'Enter a valid password';
//                   }
//                   if (!_validatePasswords()) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 600),
//               CustomButton(
//                 text: "Next",
//                 onPressed: () {
//                   if (_validatePasswords()) {
//                     _registerUser(); // Call the method to handle registration
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Already have an account? ",
//                       style: GoogleFonts.urbanist()),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SigninScreen()));
//                     },
//                     child: Text(
//                       "Login Now",
//                       style: GoogleFonts.urbanist(
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.orange,
//                           )),
//                     ),
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
