import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth_screen/log_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB91D), // Yellow background
      body: Center(
        child:
            // RotatedBox(
            //   quarterTurns: -1, // Rotates the screen to match the image
            //   child:
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // QR Icon
              Image.asset(
                'assets/splash2.png', // Replace with your actual asset
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 100),

              // Description Text
              const Text(
                "Go and enjoy our features for free and\nmake your life easy with us.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Let's Start Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                  // Navigate to next screen here
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  "Let's Start",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
