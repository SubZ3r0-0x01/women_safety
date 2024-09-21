// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  CustomBottomBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.orange, // Default background color
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, "Home", 0),
            _buildNavItem(Icons.chat, "Chat", 1),
            _buildNavItem(Icons.person, "Contacts", 2),
            _buildNavItem(Icons.settings, "Settings", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index; // Determine if the item is selected

    return GestureDetector(
      onTap: () => onTap(index), // Handle tap
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent, // Set background color to white when selected, transparent otherwise
          borderRadius: BorderRadius.circular(10), // Optional rounded corners for better aesthetics
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Let the row be as wide as its children
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black,
            ),
            SizedBox(width: 8), // Space between icon and text
            if (isSelected) // Show label only when the item is selected
              Text(
                label,
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
              ),
          ],
        ),
      ),
    );
  }
}
