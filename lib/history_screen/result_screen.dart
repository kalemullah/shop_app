// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ResultScreen extends StatelessWidget {
//   final String name;
//   final String qr;
//   final DateTime createdAt;

//   const ResultScreen({
//     super.key,
//     required this.name,
//     required this.qr,
//     required this.createdAt,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final formattedDate = DateFormat('d MMM yyyy, h:mm a').format(createdAt);

//     return Scaffold(
//       backgroundColor: const Color(0xFF1C1C1E),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1C1C1E),
//         elevation: 0,
//         title: const Text('Result', style: TextStyle(color: Colors.white)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2C2C2E),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(Icons.qr_code,
//                           color: Color(0xFFFFC727), size: 32),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Data",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16)),
//                           const SizedBox(height: 4),
//                           Text(formattedDate,
//                               style:
//                                   TextStyle(color: Colors.grey, fontSize: 12)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Divider(color: Colors.grey[700]),
//                   const SizedBox(height: 12),
//                   Text(
//                     qr,
//                     style: const TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Show QR Code',
//                     style: TextStyle(color: Color(0xFFFFC727), fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _iconButton(Icons.share, 'Share'),
//                 _iconButton(Icons.copy, 'Copy'),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _iconButton(IconData icon, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFFC727),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: Colors.black),
//         ),
//         const SizedBox(height: 6),
//         Text(label, style: const TextStyle(color: Colors.white)),
//       ],
//     );
//   }
// }
