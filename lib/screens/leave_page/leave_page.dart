import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  DateTime _dateTime = DateTime.now();
  final DateTime? date = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final item1 = ["Half Day", "Full Day"];
  final item2 = ["Medical", "Casual"];
  String? valueChoose1;
  String? valueChoose2;

  TextEditingController reason = TextEditingController();
  final nameEditingController = TextEditingController();
  final departmentNameEditingController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late var uid = user?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Leave",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      "${_dateTime.day.toString()}:${_dateTime.month.toString()}:${_dateTime.year.toString()}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    MaterialButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: Colors.teal,
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: const SizedBox(),
                    iconSize: 36,
                    hint: const Text("Half Day or Full Day"),
                    value: valueChoose1,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose1 = newValue as String?;
                      });
                    },
                    items: item1.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: const SizedBox(),
                    iconSize: 36,
                    hint: const Text("Select Type of Leave"),
                    value: valueChoose2,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose2 = newValue as String?;
                      });
                    },
                    items: item2.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: reason,
                  minLines: 2,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type here your message",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: Colors.teal,
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Center(
                          child: Text("Leave Submit Successfull"),
                        );
                      });

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  Object? userEmail = "";

                  if (prefs.containsKey("email")) {
                    userEmail = prefs.get("email");
                  }

                  FirebaseFirestore.instance
                      .collection("leave")
                      .doc(DateTime.now().millisecondsSinceEpoch.toString())
                      .set({
                    "date":
                        "${_dateTime.day.toString()}:${_dateTime.month.toString()}:${_dateTime.year.toString()}",
                    "day-type": "${valueChoose1.toString()}",
                    "leave-type": "${valueChoose2.toString()}",
                    "reason": "${reason.text.toString()}",
                    "email": userEmail,
                  });

                  // print("${valueChoose1.toString()}"
                  //     "${valueChoose2.toString()}"
                  //     "${reason.text.toString()}"
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
