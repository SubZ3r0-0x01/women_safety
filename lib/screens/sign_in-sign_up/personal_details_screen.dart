// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print
//
// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:women_safety/widgets/custom_appbar.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:women_safety/screens/sign_in-sign_up/signin_screen.dart';
// import 'package:women_safety/screens/sign_in-sign_up/signup_type_screen.dart';
//
// class PersonalDetailsScreen extends StatefulWidget {
//   const PersonalDetailsScreen({super.key});
//
//   @override
//   State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
// }
//
// class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
//   File? _profilePicture;
//   String? _selectedGender;
//   bool _isPermissionGranted = false;
//   bool _isLoading = false;
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _mobileNumberController = TextEditingController();
//   final TextEditingController _occupationController = TextEditingController();
//
//   // Function to open the Date Picker
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900), // The minimum selectable date
//       lastDate: DateTime(2100),  // The maximum selectable date
//     );
//
//     if (picked != null) {
//       setState(() {
//         // Format the date as 'dd-MM-yyyy' using intl package
//         _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
//       });
//     }
//   }
//
//   // Function to request storage permission
//   Future<void> _requestStoragePermission() async {
//     final permissionStatus = await Permission.storage.request();
//
//     setState(() {
//       _isPermissionGranted = permissionStatus.isGranted;
//     });
//   }
//
//   // Function to open image picker
//   void _openImagePicker() async {
//     if (_isPermissionGranted) {
//       final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         setState(() {
//           _profilePicture = File(pickedFile.path);
//         });
//       }
//     } else {
//       print('Storage permission not granted');
//     }
//   }
//
//   // Function to save user details to Firebase
//   Future<void> _saveUserDetails() async {
//     _showLoadingDialog(); // Show loading dialog
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userId = user.uid;
//         final imageUrl = _profilePicture != null ? await _uploadImage() : null;
//
//         await FirebaseFirestore.instance.collection('users').doc(userId).set({
//           'firstName': _firstNameController.text,
//           'lastName': _lastNameController.text,
//           'dateOfBirth': _dateController.text,
//           'mobileNumber': _mobileNumberController.text,
//           'occupation': _occupationController.text,
//           'gender': _selectedGender,
//           'profilePicture': imageUrl,
//         });
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SigninScreen()), // Change to LoginPage if needed
//         );
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error saving user details: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save user details. Please try again.')),
//       );
//     } finally {
//       Navigator.of(context).pop(); // Close the loading dialog
//     }
//   }
//
//   // Function to upload profile picture to Firebase Storage
//   Future<String?> _uploadImage() async {
//     if (_profilePicture == null) {
//       return null; // No image selected
//     }
//
//     try {
//       // Create a reference to Firebase Storage
//       final storageRef = FirebaseStorage.instance.ref();
//
//       // Create a unique file name using the current timestamp and file extension
//       final fileName = path.basename(_profilePicture!.path);
//       final fileRef = storageRef.child('profile_pictures/$fileName');
//
//       // Upload the image file to Firebase Storage
//       final uploadTask = fileRef.putFile(_profilePicture!);
//
//       // Get the download URL of the uploaded image
//       final snapshot = await uploadTask.whenComplete(() {});
//       final downloadUrl = await snapshot.ref.getDownloadURL();
//
//       return downloadUrl;
//     } catch (e) {
//       // Handle any errors that occur during the upload
//       print('Error uploading image: $e');
//       return null;
//     }
//   }
//
//   // Function to show loading dialog
//   void _showLoadingDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(width: 20),
//               Text("Loading..."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => SignupTypeScreen()));
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
//                 style: GoogleFonts.urbanist(textStyle: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 )),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Please provide your basic details to create your profile.',
//                 style: GoogleFonts.urbanist(textStyle: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 )),
//               ),
//               SizedBox(height: 40),
//               Center(
//                 child: Stack(
//                   children: [
//                     GestureDetector(
//                       onTap: _requestStoragePermission,
//                       child: CircleAvatar(
//                           radius: 60,
//                           backgroundColor: Colors.grey[300],
//                           child: _profilePicture != null ?
//                           ClipOval(child: Image.file(_profilePicture!, fit: BoxFit.cover)) :
//                           Icon(
//                             Icons.person,
//                             size: 60,
//                             color: Colors.white,
//                           )
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: _openImagePicker,
//                         child: CircleAvatar(
//                           radius: 20,
//                           backgroundColor: Colors.white,
//                           child: SvgPicture.asset(
//                             "assets/icons/gallery-icon.svg",
//                             height: 30,
//                             width: 30,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 80),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(
//                   labelText: 'First Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Last Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _dateController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Date of Birth',
//                   hintText: '27-04-1979',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   suffixIcon: Icon(Icons.calendar_month),
//                 ),
//                 onTap: () {
//                   _selectDate(context);  // Trigger the date picker
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _mobileNumberController,
//                 decoration: InputDecoration(
//                   labelText: 'Mobile Number',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _occupationController,
//                 decoration: InputDecoration(
//                   labelText: 'Occupation',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text(
//                     'Gender:',
//                     style: GoogleFonts.urbanist(
//                       textStyle: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   Row(
//                     children: [
//                       Radio<String>(
//                         value: 'Male',
//                         groupValue: _selectedGender,
//                         onChanged: (String? value) {
//                           setState(() {
//                             _selectedGender = value;
//                           });
//                         },
//                       ),
//                       Text('Male'),
//                       SizedBox(width: 10),
//                       Radio<String>(
//                         value: 'Female',
//                         groupValue: _selectedGender,
//                         onChanged: (String? value) {
//                           setState(() {
//                             _selectedGender = value;
//                           });
//                         },
//                       ),
//                       Text('Female'),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 220),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 220,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SignupTypeScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Previous',
//                         style: GoogleFonts.urbanist(
//                           textStyle: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   SizedBox(
//                     width: 220,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: _saveUserDetails,
//                       child: Text(
//                         'Verify',
//                         style: GoogleFonts.urbanist(
//                           textStyle: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               if (_isLoading)
//                 Center(
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
