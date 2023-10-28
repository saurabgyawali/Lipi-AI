import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? selectedimage;

  Future _pickImageFromGallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 560,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://i.pinimg.com/originals/1e/2e/48/1e2e481c5942e5f321c002a797d7cf75.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://seeklogo.com/images/1/3d-cube-logo-781DAE0E80-seeklogo.com.png?v=638266607790000000",
                              height: 60,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "LIPI AI",
                              style: GoogleFonts.abel(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  _pickImageFromGallery()
                      .whenComplete(() => selectedimage != null
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Column(
                                      children: [Image.file(selectedimage!)],
                                    ),
                                  ))
                          : DoNothingAction());
                },
                child: const Text(
                  "UPLOAD IMAGE",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {},
                child: const Text(
                  "CAPTURE IMAGE",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
