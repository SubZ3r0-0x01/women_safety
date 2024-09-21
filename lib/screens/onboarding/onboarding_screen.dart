// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety/screens/sign_in-sign_up/signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<Widget> _buildPageContent() {
    return [
      OnboardingPage(
        imagePath: 'assets/images/onboarding-screen-1.svg', // SVG asset
        title: 'Connecting You to Safety',
        description:
            'Every second counts. We ensure that you\'re never alone when you need help the most.',
      ),
      OnboardingPage(
        imagePath: 'assets/images/onboarding-screen-2.svg', // SVG asset
        title: 'Help is Just a Tap Away',
        description:
            'In moments of uncertainty, we\'re here for you. Reach out with confidence, knowing help is always close at hand.',
      ),
      OnboardingPage(
        imagePath: 'assets/images/onboarding-screen-3.svg', // SVG asset
        title: 'Be the Hero, Respond in Time',
        description:
            'Your quick response can make all the difference. Stand ready to assist those in need, be the hero in someone\'s story!',
      ),
      OnboardingPage(
        imagePath: 'assets/images/onboarding-screen-4.svg', // SVG asset
        title: 'Your Feedback Matters! Give Us Rating',
        description:
            'We strive to improve your experience with every update. Let us know how we\'re doing!',
      ),
      OnboardingPage(
        imagePath: 'assets/images/onboarding-screen-5.svg', // SVG asset
        title: 'Stay Alert, Stay Safe! with Notifications',
        description:
            'We\'ll send you notifications to keep you informed about emergency updates and important alerts.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Disable swiping with NeverScrollableScrollPhysics
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // Disable touch sliding
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _buildPageContent(),
          ),
          // Page indicators with active border
          Positioned(
            bottom: 470,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _buildPageContent().length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                    border: _currentIndex == index
                        ? Border.all(
                            color: Colors.orange,
                            width: 2) // Add border for active dot
                        : null,
                  ),
                ),
              ),
            ),
          ),
          // Button to go to the next page
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_currentIndex == _buildPageContent().length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninScreen(),
                    ),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  _currentIndex == _buildPageContent().length - 1
                      ? 'Get Started'
                      : 'Next',
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, height: 250),
          SizedBox(height: 60),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
