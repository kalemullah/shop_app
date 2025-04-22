import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth_screen/sign_up_screen.dart';
import 'package:shop_app/screens/qr_screen.dart';

class SplashService {
  void islogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const QRViewExample()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
      }
    });
  }
}