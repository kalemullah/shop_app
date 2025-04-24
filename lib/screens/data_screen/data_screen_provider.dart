import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> addData(String qr, BuildContext context) async {
    isloading = true;
    notifyListeners();

    try {
      final name = nameController.text.trim();
      if (name.isEmpty || image == null || qr.trim().isEmpty) {
        throw Exception("Name, Image, and QR must not be empty");
      }

      String fileName = 'products/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(fileName).putFile(image!);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> productData = {
        'name': name,
        'qr': qr,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('shopProduct')
          .add(productData);

      nameController.clear();
      image = null;

      Navigator.pushReplacementNamed(context, '/history');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${e.toString()}"),
        backgroundColor: Colors.red,
      ));
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
