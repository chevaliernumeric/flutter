import 'package:flutter/material.dart';

class EditDetail extends StatelessWidget {
  const EditDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(213, 138, 21, 21),
        title: const Text('Details demande'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Demandé par :",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              "Mamadou Lamine le 19/07/22",
              style: TextStyle(),
            ),
            const SizedBox(height: 10),
            const Text(
              "Nom du patient:",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              "Assane",
              style: TextStyle(),
            ),
            const SizedBox(height: 10),
            const Text(
              "Centre de Santé:",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              "Hopital Grand Mbour",
              style: TextStyle(),
            ),
            const SizedBox(height: 10),
            const Text(
              "Groupe Sanguin:",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              "AB",
              style: TextStyle(),
            ),
            const SizedBox(height: 10),
            const Text(
              "Donneur Possible:",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              "A+ / A- / B+ / B- / AB+ / AB- / O+ / O-",
              style: TextStyle(),
            ),
            const SizedBox(height: 10),
            const Text(
              "Note:",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Text(
              "Urgent",
              style: TextStyle(),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey,
              height: 50,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.map,
                      color: Color.fromARGB(213, 138, 21, 21),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Localisation",
                    style: TextStyle(
                      color: Color.fromARGB(213, 138, 21, 21),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 35),
                  const VerticalDivider(
                    color: Colors.grey,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: Color.fromARGB(213, 138, 21, 21),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Partager",
                    style: TextStyle(
                      color: Color.fromARGB(213, 138, 21, 21),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(213, 138, 21, 21),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Contacter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Terminer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
    );
  }
}
