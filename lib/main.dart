//import 'dart:html';
// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const ImagePick(),
    );
  }
}

class ImagePick extends StatefulWidget {
  const ImagePick({key}) : super(key: key);

  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File image;
  //Creating and instanciating imagepicker object
  final imagePicker = ImagePicker();

  Future getImage(ImageSource source) async {
    final imagefile = await imagePicker.getImage(source: source);
    if (imagefile == null) return;
    setState(() {
      image = File(imagefile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: image == null ? null : FileImage(image),
                  ),
                  Positioned(
                    top: 150,
                    left: 110,
                    child: RawMaterialButton(
                      padding: EdgeInsets.all(12.0),
                      elevation: 5,
                      highlightColor: Colors.indigoAccent,
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                      ),
                      fillColor: Colors.black26,
                      shape: const CircleBorder(),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Choose Option',
                                  style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            getImage(ImageSource.camera),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.camera,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Times New Roman",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            getImage(ImageSource.gallery),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.photo,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Times New Roman",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            Navigator.pop(context, true),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Times New Roman",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                // ignore: deprecated_member_use
                child: RaisedButton.icon(
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () => getImage(ImageSource.gallery),
                  color: Colors.indigoAccent.shade100,
                  // ignore: prefer_const_constructors
                  icon: Icon(Icons.image_outlined),
                  // ignore: prefer_const_constructors
                  label: Text(
                    "Pick an Image",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Times New Roman",
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              Container(
                // ignore: deprecated_member_use
                child: RaisedButton.icon(
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () => getImage(ImageSource.camera),
                  color: Colors.indigoAccent.shade100,
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text(
                    "Click an Image",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Times New Roman",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
