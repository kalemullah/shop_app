import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/custom_widget/custom_button.dart';
import 'package:shop_app/custom_widget/pop_up.dart';
import 'package:shop_app/screens/auth_screen/log_in_screen.dart';
import 'package:shop_app/screens/home_screen/home.dart';
import 'package:shop_app/screens/qr_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance.collection('users');
  TextEditingController passwordController = TextEditingController();

  // Animation Controllers
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  // Error handling animations
  late AnimationController _errorController;
  late Animation<double> _errorAnimation;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeInAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Error message animation
    _errorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _errorAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _errorController,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Start the animation for the form.
  }

  void signup() {
    setState(() {
      isloading = true;
    });
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString().trim(),
            password: passwordController.text.toString().trim())
        .then((v) {
      ref.doc(v.user!.uid).set({
        'email': emailController.text.toString().trim(),
        'name': nameController.text.toString().trim(),
        'uid': v.user!.uid,
      });
      ToastPopUp().toast('Sign Up successful', Colors.green, Colors.white);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      setState(() {
        isloading = false;
      });
      emailController.clear();
      passwordController.clear();
    }).onError((Error, v) {
      setState(() {
        errorMessage = Error.toString(); // Set the error message
        _errorController.forward(); // Trigger the error animation
        isloading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not needed
    _errorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background gradient with multiple icons
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFB91D), // First color (teal)
                  Color(0xFFFFB91D) // Second color (purple)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Stack(
              children: [
                // Add multiple printer icons in the background
                // Positioned(
                //   top: 50,
                //   left: 30,
                //   child: Opacity(
                //     opacity: 0.1, // Make icons subtle
                //     child: Icon(
                //       Icons.print,
                //       size: 100,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // Positioned(
                //   top: 150,
                //   left: 100,
                //   child: Opacity(
                //     opacity: 0.1,
                //     child: Icon(
                //       Icons.print,
                //       size: 120,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 100,
                //   right: 50,
                //   child: Opacity(
                //     opacity: 0.1,
                //     child: Icon(
                //       Icons.print,
                //       size: 100,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 200,
                //   left: 80,
                //   child: Opacity(
                //     opacity: 0.1,
                //     child: Icon(
                //       Icons.print,
                //       size: 110,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Main content (Form fields, buttons, etc.)
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h),
                    // Animated Text for Form Title (e.g., "Sign Up")
                    FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Text(
                        'Create Your Account',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      color: Colors.white.withOpacity(0.8),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 15.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      color: Colors.white.withOpacity(0.8),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: Colors.black, width: 5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 15.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      color: Colors.white.withOpacity(0.8),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 15.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Sign Up',
                      height: 50.h,
                      width: 200.w,
                      isloading: isloading,
                      color: Colors.black,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup();
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    // Animated error message
                    AnimatedBuilder(
                      animation: _errorController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _errorAnimation.value,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.red.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              errorMessage ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text('Sign In',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    // OR Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Or sign up with',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

// Social login buttons (UI only)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Google Button
                        GestureDetector(
                          onTap: () {
                            // Placeholder for Google login
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25.r,
                            child: Image.asset(
                              'assets/google2.png', // Make sure you have this image
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                        ),

                        // Facebook Button
                        GestureDetector(
                          onTap: () {
                            // Placeholder for Facebook login
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25.r,
                            child: Image.asset(
                              'assets/facebook.jpg', // Make sure you have this image
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                        ),

                        // Apple Button
                        GestureDetector(
                          onTap: () {
                            // Placeholder for Apple login
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25.r,
                            child: Icon(Icons.apple,
                                size: 30.sp, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
