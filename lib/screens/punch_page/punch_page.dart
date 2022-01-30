import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animate_do/animate_do.dart';

class PunchPage extends StatefulWidget {
  const PunchPage({Key? key}) : super(key: key);

  @override
  State<PunchPage> createState() => _PunchPageState();
}

class _PunchPageState extends State<PunchPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isloading = true;
  bool puchloading = true;
  final DateTime _dateTime = DateTime.now();
  final DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            child: Text(
              "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Lets get to work", style: TextStyle(fontSize: 16)),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.work_outline),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                child: const Text(
                  "PUNCH IN",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Text("Punch In Successfull"),
                        );
                      });

                  FirebaseFirestore.instance.collection("punching").add({
                    "punch-time":
                    "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                    "punch-date":
                    "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}"
                  });

                  print("${_dateTime.hour.toString()}:${_dateTime.minute.toString()} - "
                      "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}");

                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          const SizedBox(
            height: 100,
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                child: const Text("PUNCH OUT",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Text("Puch Out Successfull"),
                        );
                      });
                  FirebaseFirestore.instance.collection("punching").add({
                    "punchout-time":
                    "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                    "punchout-date":
                    "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}"
                  });
                  print("${_dateTime.hour.toString()}:${_dateTime.minute.toString()}"
                      "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}");

                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          puchloading
              ? const SizedBox()
              : const Text("Succesfully punched Out",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
