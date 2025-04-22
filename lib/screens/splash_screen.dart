import 'package:flutter/material.dart';
import 'package:shop_app/firebase_service/check_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashService().islogin(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6c8b4).withOpacity(.8),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                'assets/profile.jpeg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
