import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late var uid = user?.uid;

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
                  if ((DateTime.now().hour > 9) ||
                      (DateTime.now().hour == 9 &&
                          DateTime.now().minute > 30)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: Text("Time is Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),),
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: Text("Punching Successful",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          );
                        });

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    Object? userEmail = "";
                    if (prefs.containsKey("email")) {
                      userEmail = prefs.get("email");
                    }

                    FirebaseFirestore.instance
                        .collection("punching")
                        .doc(DateTime.now().millisecondsSinceEpoch.toString())
                        .set({
                      "punch-time":
                          "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                      "punch-date":
                          "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}",
                      "email": userEmail
                    });
                  }
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
                  if ((DateTime.now().hour < 17)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: Text("Time not Yet",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),),
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: Text("Puch Out Successfull",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),),
                          );
                        });

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    Object? userEmail = "";
                    if (prefs.containsKey("email")) {
                      userEmail = prefs.get("email");
                    }

                    FirebaseFirestore.instance
                        .collection("leaving")
                        .doc(DateTime.now().millisecondsSinceEpoch.toString())
                        .set({
                      "punchOut-time":
                          "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                      "punchOut-date":
                          "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}",
                      "email": userEmail
                    });
                  }
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
