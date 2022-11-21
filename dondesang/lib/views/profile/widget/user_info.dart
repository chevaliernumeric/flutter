import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class GetUserData extends StatelessWidget {
  final String fieldName;
  final String fieldEmail;
  final String fieldBlood;
  GetUserData(this.fieldName, this.fieldEmail, this.fieldBlood, {Key? key})
      : super(key: key);
  final curentUser = auth.currentUser;
//  final userID = curentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = firestore.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(curentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'Un problème est survenu',
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data;
          if (snapshot.data!.data() != null) {
            data = snapshot.data!.data() as Map<String, dynamic>;
            print(data);
            Column(
              children: [
                Text(
                  data[fieldName],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data[fieldEmail],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 30,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/goutte.png",
                        color: Colors.red[300],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: Text(
                          data[fieldBlood],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            print('pas cool');
            print('je suis perdue : $users');
          }
        }
        return const Text(
          'En cours de chargement',
        );
      },
    );
  }
}
