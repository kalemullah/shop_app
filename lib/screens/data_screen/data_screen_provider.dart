import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DataScreenProvider extends ChangeNotifier {
  bool isloading = false;
  File? image;
  TextEditingController nameController = TextEditingController();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> addData(String qr) async {
    print("Adding data...");
    isloading = true;
    notifyListeners();

    try {
      final name = nameController.text.trim();
      if (name.isEmpty || image == null || qr.trim().isEmpty) {
        throw Exception("Name, Image, and QR must not be empty");
      }

      // Upload image to Firebase Storage
      String fileName = 'products/${DateTime.now().millisecondsSinceEpoch}.jpg';

      UploadTask uploadTask =
          FirebaseStorage.instance.ref(fileName).putFile(image!);

      TaskSnapshot snapshot = await uploadTask;
      print("Image path: ${uploadTask}");
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Prepare product data
      Map<String, dynamic> productData = {
        'name': name,
        'qr': qr,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('shopProduct')
          .add(productData);

      // Reset fields
      nameController.clear();
      image = null;
    } catch (e) {
      debugPrint("Error adding product: $e");
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
