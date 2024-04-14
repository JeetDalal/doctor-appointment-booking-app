import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_reminder/services/auth_service.dart';
import 'package:stock_reminder/services/hospital_services.dart';
import 'package:stock_reminder/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  String userName = "";

  getUserName() async {
    final details = await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().currentUser!.uid)
        .get();
    setState(() {
      userName = (details.data() as Map<String, dynamic>)['name'];
    });
  }

  File? _image;

  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       setState(() {
  //         _image = File(pickedFile.path);
  //       });
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 100,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 80,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                userName,
                style: GoogleFonts.inter(
                    color: primaryButtonColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  await AuthService().logout(context);
                },
                child: Text(
                  'logout',
                  style: GoogleFonts.inter(),
                ),
              )
            ],
          )),
    );
  }
}
