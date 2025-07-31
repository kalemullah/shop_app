import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shop_app/screens/auth_screen/log_in_screen.dart';
import 'package:shop_app/history_screen/history_screen.dart';
import 'package:shop_app/screens/qr_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _printerController;
  late Animation<double> _printerAnimation;

  late AnimationController _pageController;
  late Animation<double> _pageAnimation;

  @override
  void initState() {
    super.initState();

    _printerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _printerAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _printerController, curve: Curves.easeInOut),
    );

    _pageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _pageAnimation = Tween<double>(begin: 0, end: 40).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _printerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB91D),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Welcome ",
                style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
              ),
            ),

            const Spacer(),

            // Logout button
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Navigate to login screen or show confirmation
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    )); // or any route you use
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Printer Icon Animation
            // AnimatedBuilder(
            //   animation: _printerAnimation,
            //   builder: (context, child) {
            //     return Transform.translate(
            //       offset: Offset(0, _printerAnimation.value),
            //       child: Lottie.asset(
            //         'assets/scanner.json',
            //         width: 150,
            //         height: 150,
            //         fit: BoxFit.fill,
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 20),
            // Page Coming Out Animation
            CarouselSlider(
              options: CarouselOptions(
                height: 200.h,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: [
                // Add more images here if needed
                'assets/slide1.jpeg',
                'assets/slide2.jpg',
                'assets/slide3.png',
              ].map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 50),

            // Buttons
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: Duration(milliseconds: 3000),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.qr_code_scanner, size: 28),
                        label: Text("QR Code Scanner",
                            style: GoogleFonts.poppins(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRViewExample(),
                              ));
                          // Navigate to QR Scanner
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 3000),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.history_edu, size: 28),
                        label: Text("History",
                            style: GoogleFonts.poppins(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreen(),
                              ));
                          // Navigate to Barcode Scanner
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
