import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/data_screen/data_screen_provider.dart';
import 'package:shop_app/custom_widget/custom_button.dart';
import 'package:shop_app/history_screen/history_screen.dart';
import 'package:shop_app/screens/home_screen/home.dart';

class DataScreen extends StatelessWidget {
  final String? data;
  const DataScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataScreenProvider(),
      child: Consumer<DataScreenProvider>(
        builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: const Color(0xFFFFB91D),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                QRInfoWidget(data: data),
                SizedBox(height: 20.h),
                ImagePickerWidget(
                  image: model.image,
                  onTap: model.pickImage,
                ),
                SizedBox(height: 20.h),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: model.nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter product name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () async {
                    String scannedQrCode = data ?? '';

                    if (scannedQrCode.isEmpty) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("QR code is missing."),
                      //   backgroundColor: Colors.red,
                      // ));
                      return;
                    }

                    final provider =
                        Provider.of<DataScreenProvider>(context, listen: false);

                    final existing = await FirebaseFirestore.instance
                        .collection('shopProduct')
                        .where('qr', isEqualTo: scannedQrCode)
                        .get();

                    if (existing.docs.isNotEmpty) {
                      // 🚫 QR already scanned
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("This QR code is already scanned."),
                        backgroundColor: Colors.orange,
                      ));
                      // Stay on the same screen (do not navigate)
                    } else {
                      // ✅ Add product and navigate to history
                      await provider.addData(scannedQrCode, context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()),
                      );
                    }
                  },
                  child: Consumer<DataScreenProvider>(
                    builder: (context, provider, child) {
                      return provider.isloading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text("Add Product");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ----------------------
/// QR Info Widget
/// ----------------------
class QRInfoWidget extends StatelessWidget {
  final String? data;
  const QRInfoWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      "QR: ${data ?? 'N/A'}",
      style: TextStyle(color: Colors.black),
    );
  }
}

/// ----------------------
/// Image Picker Widget
/// ----------------------
class ImagePickerWidget extends StatelessWidget {
  final dynamic image;
  final VoidCallback onTap;
  const ImagePickerWidget(
      {super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: image == null
            ? const Center(
                child: Text(
                  'Tap to take picture',
                  style: TextStyle(color: Colors.black),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(image, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
