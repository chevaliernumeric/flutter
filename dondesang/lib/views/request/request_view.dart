import 'package:flutter/material.dart';

import './widget/request_form.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(213, 138, 21, 21),
        title: const Text("Don de Sang"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(5),
          child: RequestForm(),
        ),
      ),
    );
  }
}
