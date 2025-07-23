import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final String docId;
  final String name;
  final String qr;
  final String imageUrl;
  final Timestamp? createdAt;

  const ProductCard({
    super.key,
    required this.docId,
    required this.name,
    required this.qr,
    required this.imageUrl,
    this.createdAt,
  });

  void _deleteItem(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('shopProduct')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = createdAt != null
        ? DateFormat('yyyy-MM-dd – kk:mm').format(createdAt!.toDate())
        : 'No date';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        // contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: imageUrl.isNotEmpty
            ? SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 50);
                  },
                ),
              )
            : const Icon(Icons.image_not_supported),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("QR: $qr"),
            Text("Date: $formattedDate"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _deleteItem(context),
        ),
      ),
    );
  }
}
