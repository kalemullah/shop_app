import 'package:flutter/material.dart';
import 'package:shop_app/firebase_service/check_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Simulate splash screen logic like navigation
    Future.delayed(const Duration(seconds: 3), () {
      SplashService().islogin(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient with multiple icons
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.shade300, // First color (teal)
                  Colors.purple.shade600, // Second color (purple)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Add multiple printer icons in the background
                Positioned(
                  top: 50,
                  left: 30,
                  child: Opacity(
                    opacity: 0.1, // Make icons subtle
                    child: Icon(
                      Icons.print,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 100,
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.print,
                      size: 120,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 50,
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.print,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 200,
                  left: 80,
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.print,
                      size: 110,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content (CircleAvatar and Text)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Text(
                    "Welcome to MyShop",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
