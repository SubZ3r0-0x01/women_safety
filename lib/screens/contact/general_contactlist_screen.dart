// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety/widgets/custom_bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/screens/home/general_home_screen.dart';
import 'package:women_safety/screens/chat/general_chat_screen.dart';

class GeneralContactlistScreen extends StatefulWidget {
  const GeneralContactlistScreen({super.key});

  @override
  State<GeneralContactlistScreen> createState() =>
      _GeneralContactlistScreenState();
}

class _GeneralContactlistScreenState extends State<GeneralContactlistScreen> {
  int _selectedIndex = 2;
  List<Map<String, String>> contacts = [];
  List<Map<String, String>> filteredContacts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedContacts = prefs.getString('contacts');

    if (storedContacts != null) {
      try {
        setState(() {
          contacts =
              List<Map<String, String>>.from(json.decode(storedContacts));
          filteredContacts = contacts;
        });
      } catch (e) {
        print('Error decoding contacts: $e');
      }
    } else {
      print('No stored contacts found');
    }
  }

  Future<void> _saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString('contacts', json.encode(contacts));
      print('Contacts saved successfully');
    } catch (e) {
      print('Error saving contacts: $e');
    }
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
      // Navigate to Chat screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GeneralChatScreen()));
        break;
      case 2:
      // Stay on Contacts screen
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
        title: Text("Contacts",
            style: GoogleFonts.urbanist(
                textStyle:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.white,
      body: contacts.isEmpty
          ? Center(
              child: Text('No contacts were added',
                  style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600))))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query.toLowerCase();
                        filteredContacts = contacts
                            .where((contact) => contact['name']!
                                .toLowerCase()
                                .contains(searchQuery))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search Contacts",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchQuery.isEmpty
                        ? contacts.length
                        : filteredContacts.length,
                    itemBuilder: (context, index) {
                      var contact = searchQuery.isEmpty
                          ? contacts[index]
                          : filteredContacts[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.primaries[index % Colors.primaries.length],
                          child: Text(_getInitials(contact['name']!),
                              style: TextStyle(color: Colors.white)),
                        ),
                        title: Text(contact['name']!),
                        subtitle: Text(contact['phone']!),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Add your delete logic here
                            setState(() {
                              contacts.removeAt(
                                  index); // Assuming `contacts` is your contact list
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          final List<Map<String, String>>? newContacts = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactScreen()),
          );
          if (newContacts != null) {
            setState(() {
              contacts.addAll(newContacts);
              filteredContacts = contacts;
              _saveContacts();
            });
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    return nameParts.length > 1
        ? nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase()
        : nameParts[0][0].toUpperCase();
  }
}

// Add Contact
class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  List<Contact> selectedContacts = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  // Function to request permission and fetch contacts
  Future<void> _fetchContacts() async {
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted) {
      // Request permission if not already granted
      permission = await Permission.contacts.request();
    }

    if (permission == PermissionStatus.granted) {
      // Fetch contacts if permission is granted
      List<Contact> _contacts = (await ContactsService.getContacts()).toList();
      setState(() {
        contacts = _contacts;
        filteredContacts = contacts;
      });
    } else {
      print('Permission denied');
    }
  }

  // Real-time search function
  void _filterContacts(String searchTerm) {
    List<Contact> _filteredContacts = contacts
        .where((contact) => (contact.displayName ?? '')
            .toLowerCase()
            .contains(searchTerm.toLowerCase()))
        .toList();
    setState(() {
      this.searchTerm = searchTerm;
      filteredContacts = _filteredContacts;
    });
  }

  // Function to handle contact selection
  void _onContactSelected(Contact contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact);
      } else {
        selectedContacts.add(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Add Contact",
          style: GoogleFonts.urbanist(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterContacts,
              decoration: InputDecoration(
                labelText: 'Search Contacts',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Contact list with real-time search and multiple selection
          Expanded(
            child: filteredContacts.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      Contact contact = filteredContacts[index];
                      String displayName = contact.displayName ?? 'No Name';
                      String phoneNumber = contact.phones!.isNotEmpty
                          ? contact.phones!.first.value ?? 'No Number'
                          : 'No Number';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.primaries[index % Colors.primaries.length],
                          child: Text(
                            displayName.isNotEmpty
                                ? displayName[0].toUpperCase()
                                : '?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(displayName),
                        subtitle: Text(phoneNumber),
                        trailing: selectedContacts.contains(contact)
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.check_circle_outline),
                        onTap: () => _onContactSelected(contact),
                        selected: selectedContacts.contains(contact),
                        selectedTileColor: Colors.orange.shade100,
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          // Add selected contacts button
          if (selectedContacts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Map the selected contacts to a format suitable for the next screen
                  List<Map<String, String>> selectedContactsInfo =
                      selectedContacts.map((contact) {
                    return {
                      'name': contact.displayName ?? 'No Name',
                      'phone': contact.phones!.isNotEmpty
                          ? contact.phones!.first.value ?? 'No Number'
                          : 'No Number',
                    };
                  }).toList();

                  Navigator.pop(context, selectedContactsInfo);
                },
                child: Text(
                  'Add ${selectedContacts.length} Contact(s)',
                  style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
