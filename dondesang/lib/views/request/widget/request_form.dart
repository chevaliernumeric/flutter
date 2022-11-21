import 'package:dondesang/views/home/home_view.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:date_field/date_field.dart';
import "package:intl/intl.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({Key? key}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final patientField = TextEditingController();
  final phoneField = TextEditingController();
  final bloodTypeField = TextEditingController();
  final hospitalField = TextEditingController();
  final noteField = TextEditingController();
  final firestore = FirebaseFirestore.instance;
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
  DateTime selectedDate = DateTime.now();
  @override
  void dispose() {
    super.dispose();
    patientField.dispose();
    phoneField.dispose();
    bloodTypeField.dispose();
    hospitalField.dispose();
    noteField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: ListView(
        children: [
          TextFormField(
            controller: patientField,
            style: GoogleFonts.comfortaa(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Nom du patient",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: phoneField,
            style: GoogleFonts.comfortaa(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Téléphone",
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                underline: const SizedBox(),
                dropdownColor: const Color.fromARGB(213, 138, 21, 21),
                icon: Container(
                  margin: const EdgeInsets.only(left: 300),
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
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
                              color: Colors.grey,
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
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: hospitalField,
            style: GoogleFonts.comfortaa(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Centre de santé",
            ),
          ),
          const SizedBox(height: 10),
          DateTimeFormField(
            dateFormat: DateFormat('M/d/y'),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.comfortaa(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              errorStyle: const TextStyle(color: Colors.redAccent),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: const Icon(Icons.event_note),
              hintText: 'Date',
            ),
            mode: DateTimeFieldPickerMode.date,
            autovalidateMode: AutovalidateMode.always,
            validator: (e) =>
                (e?.day ?? 0) == 1 ? 'C\'est pas la premier date' : null,
            onDateSelected: (DateTime value) {
              selectedDate = value;
              print(value);
            },
            onSaved: (DateTime? value) {
              selectedDate = value!;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: noteField,
            maxLines: 4,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.comfortaa(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Descriprion",
            ),
          ),
          const SizedBox(height: 10),
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
                  requestForm();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeView();
                  }));
                },
                child: const Text(
                  "Demander",
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

  void requestForm() {
    try {
      var deteformat = selectedDate;
      var dateF = DateFormat('M/d/y');
      firestore.collection("request").add({
        "name": patientField.text.trim(),
        "phone": phoneField.text.trim(),
        "bloodType": dropdownValue,
        "hopital": hospitalField.text.trim(),
        "needTime": dateF.format(deteformat),
        "note": noteField.text.trim()
      }).then((value) {
        print(value.toString());
        patientField.clear();
        phoneField.clear();
        hospitalField.clear();
        noteField.clear();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
