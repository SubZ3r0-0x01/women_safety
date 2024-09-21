// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety/widgets/custom_bottombar.dart';
import 'package:women_safety/screens/home/general_home_screen.dart';
import 'package:women_safety/screens/contact/general_contactlist_screen.dart';

class GeneralChatScreen extends StatefulWidget {
  const GeneralChatScreen({super.key});

  @override
  State<GeneralChatScreen> createState() => _GeneralChatScreenState();
}

class _GeneralChatScreenState extends State<GeneralChatScreen> {
  int _selectedIndex = 1;
  List<Map<String, String>> contacts = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  // Function to add a new contact
  void _addContact() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        contacts.add({
          "name": _nameController.text,
          "message": _messageController.text,
          "time": "Now"
        });
      });
      _nameController.clear();
      _messageController.clear();
      Navigator.pop(context); // Close the bottom sheet
    }
  }

  // Show bottom sheet to input new contact
  void _showAddContactDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: "Contact Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(labelText: "Message"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a message";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addContact,
                      child: Text("Add Contact"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        // Navigate to Home screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GeneralHomeScreen()));
        break;
      case 1:
        // Stay on Chat screen
        break;
      case 2:
        // Navigate to Chat screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GeneralContactlistScreen()));
        break;
      case 3:
        // Navigate to Settings screen
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => GeneralSettingsScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.logout), onPressed: () {}),
        title: Text(
          "Chats",
          style: GoogleFonts.urbanist(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text("No contacts added. Press '+' to add a contact."),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
