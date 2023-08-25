import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/components/my_bottun.dart';
import 'package:untitled/components/my_textfield.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/service/auth/auth_service.dart';
import 'package:untitled/service/post_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool pickedFile = false;
  final titleController = TextEditingController();
  final discribtionController = TextEditingController();
  final placeController = TextEditingController();
  final moneyController = TextEditingController();
  var url = '';
  String? dropdownvalue = 'Food';

  void posthandele() async {
    print(dropdownvalue);
    if (titleController.text == '' &&
        discribtionController.text == '' &&
        placeController.text == '' &&
        moneyController.text == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fill all field please")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.post(titleController.text, discribtionController.text,
          placeController.text, moneyController.text, dropdownvalue!, url);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.help_center, size: 80, color: Colors.grey[800]),
                const SizedBox(
                  height: 30,
                ),
                const Text("Lets Create an account for you"),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                    controller: titleController,
                    hintText: "give a title",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: discribtionController,
                    hintText: "add describtion",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("select catagory"),
                    SizedBox(
                      width: 15,
                    ),
                    select(),
                  ],
                ),
                MyTextField(
                    controller: placeController,
                    hintText: "where is the place",
                    obscureText: false),
                MyTextField(
                    controller: moneyController,
                    hintText: "total money wanted",
                    obscureText: false),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 78, 61, 12),
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () => pickAndUploadFile(),
                    child: Text(
                      "Add image",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: pickedFile
                      ? Text("Image selected")
                      : Text("no selected image"),
                ),
                MyButton(onTop: posthandele, text: "Post"),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> items = ['Food', 'water', 'education', 'shalter'];
  Widget select() {
    return DropdownButton(
        value: dropdownvalue,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (value) {
          setState(() {
            dropdownvalue = value;
          });
        });
  }

  Future<String> uploadFileToFirebaseStorage(
      Uint8List fileData, String fileName) async {
    try {
      setState(() {
        url = 'images/${fileName}';
      });
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(url);

      // Upload the file to Firebase Storage
      firebase_storage.UploadTask uploadTask = ref.putData(fileData);

      // Await the completion of the upload task
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL of the uploaded file
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return "null";
    }
  }

  Future<void> pickAndUploadFile() async {
    // if (!Platform.isAndroid) {
    //
    // } else {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    try {
      setState(() {
        url = 'images/${DateTime.now().toString()}.png';
      });
      // Create a reference to the location you want to upload to in Firebase Storage
      final storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(url);

      // Upload the file to Firebase Storage
      await storageReference.putFile(imageTemporary);

      // Get the download URL of the uploaded image
      final imageUrl = await storageReference.getDownloadURL();

      // Do something with the download URL (e.g., save it to Firestore, display it in your app, etc.)
      setState(() {
        pickedFile = !pickedFile;
      });
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }
}
