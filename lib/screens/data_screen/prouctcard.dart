import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String qr;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.qr,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: imageUrl.isNotEmpty
            ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
            : const Icon(Icons.image_not_supported),
        title: Text(name),
        subtitle: Text("QR: $qr"),
      ),
    );
  }
}
