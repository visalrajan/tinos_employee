// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class TaskPage extends StatefulWidget {
//   const TaskPage({Key? key}) : super(key: key);
//
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }
//
// class _TaskPageState extends State<TaskPage> {
//
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   late User? user = auth.currentUser;
//   late var uid =user?.uid;
//
//   final Stream<QuerySnapshot> employee =
//   FirebaseFirestore.instance.collection("task").snapshots();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(
//           "Task",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height *7,
//             width: MediaQuery.of(context).size.width,
//             child: StreamBuilder<QuerySnapshot>(
//               stream: employee,
//               builder: (
//               BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot,
//               ) {
//                 if (snapshot.hasError) {
//                   return Text("Something Wrong");
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text("Loading");
//                 }
//                 final data = snapshot.requireData;
//                 return ListView.builder(
//                   itemCount: data.size,
//                     itemBuilder: (context, index) {
//                     final userDetails = snapshot.requireData;
//
//                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                     Object? userEmail = "";
//                     if (prefs.containsKey("email")) {
//                       userEmail = prefs.get("email");
//                     }
//
//                     return Column(
//                       children: [
//                         Text(
//                           "${data.docs[index]["task-name"]}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.teal,
//                           ),
//                         ),
//
//                       ],
//                     );
//                     }
//                 );
//               }
//             ),
//
//
//           ),
//         ],
//       ),
//
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late var uid = user?.uid;

  final Stream<QuerySnapshot> employee =
  FirebaseFirestore.instance.collection("task").snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Task",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 7,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: StreamBuilder<QuerySnapshot>(
                stream: employee,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,) {
                  if (snapshot.hasError) {
                    return Text("Something Wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  final data = snapshot.requireData;


                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        final userDetails = snapshot.requireData;
                        getUserEmail();

                        return Column(
                          children: [
                            (getUserEmail() == userDetails.docs.map((e) => e["email"])) ?

                            Text(
                              "${data.docs[index]["task-name"]}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ) : Container(
                              height: 100,
                              width: 100,
                              color: Colors.redAccent,),

                          ],
                        );
                      }
                  );
                }
            ),


          ),
        ],
      ),

    );
  }

  getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance();

    Object? userEmail = "";
    if (prefs.containsKey("email")) {
      userEmail = prefs.get("email");
    }
  }

}