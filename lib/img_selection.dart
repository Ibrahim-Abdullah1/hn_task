// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'Cameracontroller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle btnLable = new TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w900);
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  late File imagefile;

  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imagefile = File(imagepath);
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  // cropImage() async {
  //   File? croppedfile = await ImageCropper.cropImage(
  //       sourcePath: imagepath,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Image Cropper',
  //           toolbarColor: Colors.deepPurpleAccent,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         minimumAspectRatio: 1.0,
  //       ));

  //   if (croppedfile != null) {
  //     imagefile = croppedfile;
  //     setState(() {});
  //   } else {
  //     print("Image is not cropped.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cameras = availableCameras();

    final galleryLogo = new Hero(
      tag: 'Gallery Image',
      child: new CircleAvatar(
        // backgroundColor: Colors.white,
        child: new Container(
            width: 135.0,
            height: 135.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                image: const AssetImage("assets/camera.png"),
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(60.0)),
            )),
      ),
    );

    final cameraLogo = new Hero(
      tag: 'Click Photo',
      child: new CircleAvatar(
        child: new Container(
          width: 135.0,
          height: 135.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            image: new DecorationImage(
              image: const AssetImage("assets/gallery.png"),
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(80.0)),
          ),
        ),
      ),
    );

    return new Scaffold(
      body: new Builder(
        builder: (BuildContext context) {
          return new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: new Alignment(1.0, 5.0),
                // 10% of the width, so there are ten blinds.
                colors: [Colors.white, Colors.teal], // whitish to gray
              ),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Container(
                      width: 150.0,
                      height: 150.0,
                      child: galleryLogo,
                      margin: const EdgeInsets.all(16.0),
                    ),
                  ],
                ),
                new Container(
                  child: new RaisedButton(
                    padding: new EdgeInsets.all(16.0),
                    color: Colors.teal,
                    elevation: 20.0,
                    onPressed: () async {
                      await availableCameras().then(
                        (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CameraPage(cameras: value))),
                      );
                    },
                    child: new Text("Click Photo", style: btnLable),
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(60.0))),
                  ),
                  margin: new EdgeInsets.only(
                      bottom: 16.0, left: 16.0, right: 16.0),
                ),
                new Column(
                  children: <Widget>[
                    new Container(
                      width: 150.0,
                      height: 150.0,
                      child: cameraLogo,
                      margin: const EdgeInsets.all(16.0),
                    ),
                  ],
                ),
                new Container(
                  child: new RaisedButton(
                    padding: new EdgeInsets.all(16.0),
                    color: Colors.teal,
                    elevation: 20.0,
                    onPressed: () {
                      openImage();
                    },
                    child: new Text("pick Image from gallery", style: btnLable),
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(60.0))),
                  ),
                  margin: new EdgeInsets.only(
                      bottom: 16.0, left: 16.0, right: 16.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
