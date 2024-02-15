import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lipi/components/image_widget.dart';
import 'package:lipi/function.dart';
import 'package:lipi/models/recognition_response.dart';
import 'package:lipi/recognizer/interface/text_recognizer.dart';
import 'package:lipi/recognizer/tesseract_text_recognizer.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _HomeViewState();
}

class _HomeViewState extends State<PhotoScreen> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;
  RecognitionResponse? _response;
  String result = '';
  String url = '';
  var data;
  String output = '';

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _recognizer = TesseractTextRecognizer();
  }

  void processImage(String imgPath) async {
    final recognizedText = await _recognizer.processImage(imgPath);
    setState(() {
      _response = RecognitionResponse(
        imgPath: imgPath,
        recognizedText: recognizedText,
      );
    });
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  Future _pickImageFromGallery() async {
    final imgPath = await obtainImage(ImageSource.gallery);
    if (imgPath == null) return;
    Navigator.of(context).pop();
    processImage(imgPath);
    result = _response!.recognizedText;
    url = 'http://127.0.0.1:5000/api?query=' + result.toString();
    data = await fetchdata(url);
    var decoded = jsonDecode(data);
    setState(() {
      output = decoded['output'];
    });
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                children: [Text(output)],
              ),
            ));
  }

  Future _pickImageFromCamera() async {
    final imgPath = await obtainImage(ImageSource.camera);
    if (imgPath == null) return;
    Navigator.of(context).pop();
    processImage(imgPath);
    result = _response!.recognizedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: [
          SizedBox(
            height: 600,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: FloatingActionButton.extended(
              label: const Text(
                "UPLOAD IMAGE",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              backgroundColor: Colors.black,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => imagePickAlert(
                    onGalleryPressed: () async {
                      _pickImageFromGallery();
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: FloatingActionButton.extended(
              label: const Text(
                "CAPTURE IMAGE",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              backgroundColor: Colors.black,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => imagePickAlert1(
                    onCameraPressed: () async {
                      _pickImageFromCamera();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _response == null
          ? SingleChildScrollView(
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
                                    "https://firebasestorage.googleapis.com/v0/b/traffic-server-62af3.appspot.com/o/WhatsApp_Image_2023-10-21_at_16.34.08_11cc1e9f-removebg-preview%20(1).png?alt=media&token=b292e908-7e2c-47ee-bc75-b4661e004352",
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
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/originals/1e/2e/48/1e2e481c5942e5f321c002a797d7cf75.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background image
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/originals/1e/2e/48/1e2e481c5942e5f321c002a797d7cf75.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Blur overlay
                      Container(
                        height: 300,
                        width: double.infinity,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY:
                                  5), // Adjust the sigma values for the desired blur effect
                          child: Container(
                            color: Colors.black.withOpacity(
                                0), // Adjust the opacity of the overlay
                          ),
                        ),
                      ),

                      // Content on top of the blurred image
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust this value for the desired corner radius
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(File(_response!.imgPath)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Recognized Text:",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text: _response!.recognizedText),
                                );
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _response!.recognizedText,
                          style: TextStyle(fontSize: 25),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Translated Text:",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text: _response!.recognizedText),
                                );
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
