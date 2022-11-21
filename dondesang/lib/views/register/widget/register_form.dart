import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool hidePassword = true;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firstore = FirebaseFirestore.instance;

  final List<String> blood = [
    "A",
    "B",
    "AB",
    "O",
    "O+",
    "A+",
    "B+",
    "AB+",
    "O-",
    "B-",
    "AB-"
  ];
  String dropdownValue = "A";
  final nameField = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameField.dispose();
    emailField.dispose();
    passwordField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 230,
                        child: Center(
                          child: TextFormField(
                            controller: nameField,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Nom complete',
                              hintStyle:
                                  GoogleFonts.comfortaa(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.email_outlined,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 230,
                        child: Center(
                          child: TextFormField(
                            controller: emailField,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle:
                                  GoogleFonts.comfortaa(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 230,
                        child: Center(
                          child: TextFormField(
                            controller: passwordField,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            obscureText: hidePassword == true ? true : false,
                            decoration: InputDecoration(
                              hintText: 'Mot de passe',
                              hintStyle:
                                  GoogleFonts.comfortaa(color: Colors.white),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                // ignore: prefer_const_constructors
                                icon: hidePassword == true
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.bloodtype_outlined,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 230,
                        child: Center(
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            dropdownColor:
                                const Color.fromARGB(213, 138, 21, 21),
                            icon: Container(
                              margin: const EdgeInsets.only(left: 130),
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.bloodtype,
                                color: Colors.white,
                              ),
                            ),
                            value: dropdownValue,
                            items: blood
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: GoogleFonts.comfortaa(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            onSaved: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                              print(dropdownValue);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 300,
            height: 50,
            margin: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(213, 138, 21, 21),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    registerUser();
                  }
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addUserInfo(String userID, String fullName, String bloodType) {
    firstore.collection("Users").doc(userID).set({
      "fullName": fullName,
      "bloodTypt": bloodType,
    }).then((value) {
      print("utilisateur ajouté");
    }).catchError((error) => print("error: $error"));
  }

  void registerUser() {
    try {
      auth
          .createUserWithEmailAndPassword(
        email: emailField.text.trim(),
        password: emailField.text.trim(),
      )
          .then((value) {
        print(value.user!.uid);
        addUserInfo(
          value.user!.uid,
          nameField.text.trim(),
          dropdownValue,
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
