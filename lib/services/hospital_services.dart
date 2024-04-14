// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:stock_reminder/services/auth_service.dart';

// class UserServices {
//   Future uploadImage(File imageFile) async {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference storageReference =
//         storage.ref().child('images/${imageFile.path.split('/').last}');
//     UploadTask uploadTask = storageReference.putFile(imageFile);
//     await uploadTask.whenComplete(() async {
//       String url = await storageReference.getDownloadURL();
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(AuthService().currentUser!.uid)
//           .update({"imageUrl": url});
//     });
//   }
// }
