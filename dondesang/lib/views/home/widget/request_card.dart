import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          Row(
            children: [
              Image.asset("assets/images/banniere.png"),
              const Text(
                "Votre Sang peut\n"
                "Sauver des vies",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 200, 26, 13),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
