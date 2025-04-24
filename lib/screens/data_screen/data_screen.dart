import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/data_screen/data_screen_provider.dart';
import 'package:shop_app/custom_widget/custom_button.dart';
import 'package:shop_app/screens/data_screen/history_screen.dart';

class DataScreen extends StatelessWidget {
  final String? data;
  const DataScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataScreenProvider(),
      child: Consumer<DataScreenProvider>(
        builder: (context, model, _) => Scaffold(
          appBar: AppBar(title: const Text("Add Product")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Text(
                  "QR: ${data ?? 'N/A'}",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: model.pickImage,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: model.image == null
                        ? const Center(
                            child: Text(
                            'Tap to take picture',
                            style: TextStyle(color: Colors.black),
                          ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(model.image!, fit: BoxFit.cover),
                          ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: model.nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter product name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Add Product',
                  height: 50.h,
                  width: double.infinity,
                  isloading: model.isloading,
                  color: Colors.teal,
                  onPressed: () {
                    model.addData(data ?? '', context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryScreen(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
