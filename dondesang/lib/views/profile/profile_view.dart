import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './widget/profile_card.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
String userEmail = 'En cours de chargement';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

String? userID;

class _ProfileViewState extends State<ProfileView> {
  FirebaseStorage storage = FirebaseStorage.instance;

  File? _image;
  final picker = ImagePicker();
  String? userPhotoUrl;

  getProfileImage() {
    Reference ref = storage.ref().child('Users/3.png');
    ref.getDownloadURL().then((dowloadUrl) {
      setState(() {
        userPhotoUrl = dowloadUrl.toString();
      });
    }).catchError((e) {
      print('Un problème est survenu: ${e.error}');
    });
  }

  Future getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Pas d\'image séléctionner');
      }
    });
  }

  Future uploadedFile() async {
    Reference storageRef = storage.ref('Users').child('3.png');
    if (_image != null) {
      UploadTask uploadTask = storageRef.putFile(_image!);
      await uploadTask.whenComplete(() {
        print('File Uploaded');
      });
    } else {
      print('bad');
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileImage();
    if (currentUser!.email != null) {
      userEmail = currentUser!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(213, 138, 21, 21),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(213, 138, 21, 21),
        centerTitle: true,
        title: const Text("Don de Sang"),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: userPhotoUrl == null
                        ? const NetworkImage(
                            'https://icon-library.com/images/default-profile-icon/default-profile-icon-16.jpg')
                        : NetworkImage(userPhotoUrl!),
                  ),
                ),
              ),
            ),
            GetUserData(currentUser!.uid, "fullName", ""),
            Text(
              userEmail,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 40,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/goutte.png",
                    color: Colors.red[300],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 20, left: 5, right: 5, bottom: 30),
                    child: GetUserData(currentUser!.uid, "bloodTypt", ""),
                  ),
                ],
              ),
            ),
            Expanded(child: ProfileCard()),
          ],
        ),
      ),
    );
  }
}

class GetUserData extends StatelessWidget {
  final String fieldName;
  final String fieldBlood;
  final String documentId;
  const GetUserData(this.documentId, this.fieldName, this.fieldBlood,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = firestore.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'Un problème est survenu',
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Text(
                data[fieldName],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                fieldBlood,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          );
        }
        return const Text(
          'En cours de chargement',
        );
      },
    );
  }
}
