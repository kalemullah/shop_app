import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/custom_widget/custom_button.dart';
import 'package:shop_app/screens/data_screen/data_screen_provider.dart';

class DataScreen extends StatefulWidget {
  final String? data;
  const DataScreen({super.key, this.data});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataScreenProvider(),
      child: Consumer<DataScreenProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Data Screen'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Qr: ${widget.data}',
                  style: const TextStyle(color: Colors.black),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: model.pickImage,
                  child: Container(
                    height: 200,
                    width: 1.sw - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: model.image == null
                        ? const Center(
                            child: Text(
                            'Tap to take picture',
                            style: TextStyle(color: Colors.black),
                          ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              model.image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: TextFormField(
                    controller: model.nameController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        hintText: 'Enter your product name',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Add Product',
                  height: 50.h,
                  width: 200.w,
                  isloading: false,
                  color: Colors.teal,
                  onPressed: () {
                    model.addData(widget.data.toString());
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
