import 'package:flutter/material.dart';

import './widget/request_list_card.dart';
import '../request/request_view.dart';
import '../profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(213, 138, 21, 21),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: index == 0
                    ? const RequestView()
                    : index == 1
                        ? RequestListCard()
                        : const ProfileView(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: "Ajouter",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Acceuil",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
              ),
              label: "Profil",
            ),
          ],
          onTap: (int value) {
            print(value);
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }
}
