// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:intl/intl.dart';
// import 'package:tinos_employee/department_model/department_model.dart';
// import 'package:tinos_employee/screens/punching_model/punching_model.dart';
//
// class PunchPage extends StatefulWidget {
//   const PunchPage({Key? key}) : super(key: key);
//
//   @override
//   State<PunchPage> createState() => _PunchPageState();
// }
//
// class _PunchPageState extends State<PunchPage> {
//   // final  user =
//   //   FirebaseFirestore.instance.collection("flutterDep").doc(
//   //     auth.currentUser!.uid
//   // ).get();
//
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   bool isloading = true;
//   bool puchloading = true;
//   final DateTime _dateTime = DateTime.now();
//   final DateTime? date = DateTime.now();
//   String currentDate = DateFormat.yMMMd().format(DateTime.now());
//   FirebaseAuth auth = FirebaseAuth.instance;
//   PunchingModel datas = PunchingModel();
//  late  Future<DepartmentModel> dept;
//
//
//
//   @override
//   void initState()  {
//     // TODO: implement initState
//     super.initState();
//      dept =  UserDepartment().getdep();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FadeInLeft(
//             delay: const Duration(milliseconds: 100),
//             duration: const Duration(milliseconds: 1000),
//             child: Text(
//               "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
//               style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text("Lets get to work", style: TextStyle(fontSize: 16)),
//               SizedBox(
//                 width: 10,
//               ),
//               Icon(Icons.work_outline),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           FadeInLeft(
//             delay: const Duration(milliseconds: 100),
//             duration: const Duration(milliseconds: 1000),
//             child: Container(
//               width: 270,
//               decoration: BoxDecoration(
//                   color: Colors.teal, borderRadius: BorderRadius.circular(10)),
//               child: TextButton(
//                 child: const Text(
//                   "PUNCH IN",
//                   style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 onPressed: () async {
//
//
//                   // PunchingModel datas = PunchingModel();
//                   // PunchingModels input = PunchingModels();
//                   //
//                   // // datas.name = auth.currentUser!.displayName;
//                   // // datas.uid = auth.currentUser!.uid;
//                   // // datas.punchin = "${date!.hour} : ${date!.minute} : ${date!.second}";
//                   // // datas.punchout = "${date!.hour} : ${date!.minute} : ${date!.second}";
//                   // // datas.email = auth.currentUser!.email;
//                   // input.datalist = [PunchingModel(email: auth.currentUser!.email,
//                   //     name: auth.currentUser!.displayName,
//                   // uid: auth.currentUser!.uid,
//                   // punchin: "${date!.hour} : ${date!.minute} : ${date!.second}",
//                   // punchout: "${date!.hour} : ${date!.minute} : ${date!.second}"),
//                   // ];
//
//
//                await firestore.collection("punching").doc(
//                       currentDate
//                   ).collection("flutter").add(
//                    {
//                      "datas": {
//                        "uid": auth.currentUser!.uid,
//                        "name": auth.currentUser!.displayName,
//                        "email": auth.currentUser!.email,
//                        "punchin": "${date!.hour} : ${date!.minute} : ${date!.second}",
//
//
//                      }
//                    }
//                   );
//
//                   print("${_dateTime.hour.toString()}:${_dateTime.minute.toString()} - "
//                       "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}");
//
//                   // await firestore.collection("collection").doc(currentDate).set(input.toJson());
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Center(
//                           child: Text("Punch In Successfull"),
//                         );
//                       });
//
//
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//
//           const SizedBox(
//             height: 100,
//           ),
//           FadeInLeft(
//             delay: const Duration(milliseconds: 100),
//             duration: const Duration(milliseconds: 1000),
//             child: Container(
//               width: 270,
//               decoration: BoxDecoration(
//                   color: Colors.teal, borderRadius: BorderRadius.circular(10)),
//               child: TextButton(
//                 child: const Text("PUNCH OUT",
//                     style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//                 onPressed: () async {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Center(
//                           child: Text("Puch Out Successfull"),
//                         );
//                       });
//                   FirebaseFirestore.instance.collection("punching").add({
//                     "punchout-time":
//                     "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
//                     "punchout-date":
//                     "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}"
//                   });
//                   print("${_dateTime.hour.toString()}:${_dateTime.minute.toString()}"
//                       "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}");
//
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           puchloading
//               ? const SizedBox()
//               : const Text("Succesfully punched Out",
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
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
  late var uid =user?.uid;

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
                  // if((DateTime.now().hour >10) || (DateTime.now().hour == 10 && DateTime.now().minute > 10)) {
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return Center(
                  //           child: Text("Time is Up"),
                  //         );
                  //       });
                  // }else {
                  //
                  // }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Text("Punch In Successfull"),
                        );
                      });


                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Object? userEmail = "";
                  if (prefs.containsKey("email")) {
                    userEmail = prefs.get("email");
                  }

                  FirebaseFirestore.instance.collection("punching").doc(DateTime.now().millisecondsSinceEpoch.toString()).
                  set({
                    "punch-time":
                    "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                    "punch-date":
                    "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}",
                    "email": userEmail
                  });


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
                  // FirebaseFirestore.instance.collection("leaving").add({
                  //   "punchOut-time":
                  //   "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                  //   "punchOut-date":
                  //   "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}"
                  // });
                  // print("${_dateTime.hour.toString()}:${_dateTime.minute.toString()}"
                  //     "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}");

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Object? userEmail = "";
                  if (prefs.containsKey("email")) {
                    userEmail = prefs.get("email");
                  }

                  FirebaseFirestore.instance.collection("leaving").doc(DateTime.now().millisecondsSinceEpoch.toString()).
                  set({
                    "punchOut-time":
                    "${_dateTime.hour.toString()}:${_dateTime.minute.toString()}",
                    "punchOut-date":
                    "${date!.day.toString()}:${date!.month.toString()}:${date!.year.toString()}",
                    "email": userEmail
                  });

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

