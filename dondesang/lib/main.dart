import 'package:flutter/material.dart';

import 'views/welcome/welcome_view.dart';
import './views/home/home_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      print("Utilisateur non conncecté");
      runApp(const Blood());
    } else {
      print("Utilisateur connecté" + user.email!);
      runApp(const HomeView());
    }
  });
}

class Blood extends StatelessWidget {
  const Blood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeView(),
    );
  }
}
