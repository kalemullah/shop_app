import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/custom_widget/custom_button.dart';
import 'package:shop_app/custom_widget/pop_up.dart';
import 'package:shop_app/screens/auth_screen/sign_up_screen.dart';
import 'package:shop_app/screens/home_screen/home.dart';
import 'package:shop_app/screens/qr_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;

  void login() {
    setState(() {
      isloading = true;
    });
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString().trim(),
            password: passwordController.text.toString().trim())
        .then((v) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      setState(() {
        isloading = false;
      });
      ToastPopUp().toast('Sign In successful', Colors.green, Colors.white);
    }).onError((Error, v) {
      ToastPopUp().toast(Error.toString(), Colors.red, Colors.white);
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFFB91D),
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFB91D), // Transparent app bar
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background gradient with multiple icons
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         const Color(0xFFFFB91D), // First color (teal)
          //        const Color(0xFFFFB91D) // Second color (purple)
          //       ],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //   ),
          //   child: Stack(
          //     children: [
          //       // Add multiple printer icons in the background
          //       Positioned(
          //         top: 50,
          //         left: 30,
          //         child: Opacity(
          //           opacity: 0.1, // Make icons subtle
          //           child: Icon(
          //             Icons.print,
          //             size: 100,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         top: 150,
          //         left: 100,
          //         child: Opacity(
          //           opacity: 0.1,
          //           child: Icon(
          //             Icons.print,
          //             size: 120,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 100,
          //         right: 50,
          //         child: Opacity(
          //           opacity: 0.1,
          //           child: Icon(
          //             Icons.print,
          //             size: 100,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 200,
          //         left: 80,
          //         child: Opacity(
          //           opacity: 0.1,
          //           child: Icon(
          //             Icons.print,
          //             size: 110,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Main content (Form fields, buttons, etc.)
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Static Title Text
                  Text(
                    'Welcome Back!',
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
                  SizedBox(height: 30.h),
                  Container(
                    color: Colors.white,

                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.7)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: Colors.black, width: 5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    color: Colors.white,
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
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: Colors.black, width: 5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: 'Sign In',
                    height: 50.h,
                    width: 200.w,
                    isloading: isloading,
                    color: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
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
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text('Sign up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                  // CustomButton(
                  //   text: 'Sign Up',
                  //   height: 50.h,
                  //   width: 200.w,
                  //   isloading: isloading,
                  //   color: Colors.teal.withOpacity(.6),
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return SignUpScreen();
                  //     }
                  //     )
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
