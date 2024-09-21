// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:women_safety/screens/contact/general_contactlist_screen.dart';
import 'package:women_safety/widgets/custom_bottombar.dart';
import 'package:women_safety/screens/chat/general_chat_screen.dart';
import 'package:women_safety/screens/home/modal/alert_type_modal.dart';

class GeneralHomeScreen extends StatefulWidget {
  const GeneralHomeScreen({super.key});

  @override
  State<GeneralHomeScreen> createState() => _GeneralHomeScreenState();
}

class _GeneralHomeScreenState extends State<GeneralHomeScreen> {
  int _selectedIndex = 0;

  Future<void> _requestLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable them.'),
      ));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Location permissions are denied (when the app is opened).'),
        ));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.'),
      ));
      return;
    }

    // Permission granted
  }

  Future<void> _startBackgroundLocationTracking(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable them.'),
      ));
      return;
    }

    // Request permissions
    permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Location permissions are denied (when the app is opened).'),
        ));
        return;
      }
    }

    // Start background location tracking
    final stream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1000,
      ),
    );

    stream.listen((Position position) {
      // Handle the current position here
      print('Current Position: ${position.latitude}, ${position.longitude}');
    });
  }

  Future<void> _initializeApp() async {
    await _requestLocationPermission(context);
    await _startBackgroundLocationTracking(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeApp());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        // Stay on the Home screen
        break;
      case 1:
        // Navigate to Chat screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GeneralChatScreen()));
        break;
      case 2:
        // Navigate to Contacts screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GeneralContactlistScreen()));
        break;
      case 3:
        // Navigate to Settings screen
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => CameraScreen()));
        break;
    }
  }

  final List<String> imageList = [
    'assets/images/quote1.png',
    'assets/images/quote2.png',
    'assets/images/quote3.png',
    'assets/images/quote4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.logout), onPressed: () {}),
        title: Text(
          "Home",
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        viewportFraction: 0.8,
                      ),
                      items: imageList
                          .map((item) => Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),

              // Circular Button section
              Column(
                children: [
                  SizedBox(
                    width: 404,
                    height: 407,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 404,
                            height: 404,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: SizedBox(
                                    width: 404,
                                    height: 404,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 102,
                                          top: 102,
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: ShapeDecoration(
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFF7DDDD)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 79,
                                          top: 79,
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Container(
                                              width: 246,
                                              height: 246,
                                              decoration: ShapeDecoration(
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFF7DDDD)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 56,
                                          top: 56,
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Container(
                                              width: 292,
                                              height: 292,
                                              decoration: ShapeDecoration(
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFF7DDDD)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Container(
                                              width: 404,
                                              height: 404,
                                              decoration: ShapeDecoration(
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFF7DDDD)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 28,
                                          top: 28,
                                          child: Opacity(
                                            opacity: 0.60,
                                            child: Container(
                                              width: 348,
                                              height: 348,
                                              decoration: ShapeDecoration(
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFF7DDDD)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 32,
                                  top: 122,
                                  child: SizedBox(
                                    width: 340,
                                    height: 160,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            AlertTypeModal.showAlertTypeModal(
                                                context);
                                          },
                                          child: Container(
                                            width: 160,
                                            height: 160,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 21, vertical: 35),
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFF03F3F),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFF7DDDD)),
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: SvgPicture.asset(
                                                        'assets/icons/radar-icon.svg')),
                                                const SizedBox(height: 10),
                                                Text(
                                                  'Send Alert',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.urbanist(
                                                      textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                    letterSpacing: 0.24,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Tap to Send \nSOS with Location',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                          color: Color(0xFF1E3A5F),
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.24,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your location and message will be sent for quick help',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                          color: Color(0xFF1E3A5F),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 0.14,
                          letterSpacing: 0.10,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
