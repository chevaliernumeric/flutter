import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/home_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool hidePassword = true;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                            controller: emailController,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            obscureText: false,
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
                            controller: passwordController,
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
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(213, 138, 21, 21),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const HomeView();
                  // }));
                  loginToFirebase();
                },
                child: const Text(
                  "Connexion",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Rénitialiser le mot de pass',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginToFirebase() async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        print(value.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
