
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

  var buttonText = "Task Completed";



  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late var uid = user?.uid;

  final Stream<QuerySnapshot> employee =
  FirebaseFirestore.instance.collection("task").snapshots();
  String? userEmail = "";
  // List<String> userTask = [];
  List<Map<String, dynamic>> userTask = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferenceData();
    getDocs();
  }

  getPreferenceData() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance();
    if (prefs.containsKey("email")) {
      userEmail = prefs.get("email") as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    //getDocs();
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

      body:
          ListView.builder(

                  itemCount: userTask.length,
                  itemBuilder: (context, index) {
                    List<String>  memebers = userTask[index]["members"];
                    return Center(
                      //child: Text(userTask[index]),
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Text("Task Name: ${userTask[index]["task"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            ),
                          ),



                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                              ),
                              child: Column(
                                children: [

                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text("Deadline",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 145,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text("${userTask[index]["start"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.green,
                                            ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 45,
                                          width: 145,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text("${userTask[index]["end"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),


                                  Text("Members",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),

                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),



                                  Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),

                                    child: ListView.builder(
                                        itemCount: memebers.length,
                                        itemBuilder: (context, itemCountValue) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 15, top: 5),
                                            child: Text(memebers[itemCountValue],
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,

                                            ),),
                                          );

                                        }),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),


                                  ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return
                                                Center(
                                                  child: Text("Task Completed Successfull",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal,

                                                  ),),
                                                );

                                            });
                                        // QuerySnapshot querySnapshot = FirebaseFirestore.instance.collection("task").snapshots() as QuerySnapshot<Object?>;
                                        // final data = querySnapshot;

                                        // if(userTask[index]["task"] = data.docs[index]["task-name"]) {
                                        //   FirebaseFirestore.instance.collection("task").doc("1647021980703").set({
                                        //     "Status": Text("Task Completed"),
                                        //   });
                                        // }

                                        FirebaseFirestore.instance.collection("completedTask").doc(DateTime.now().millisecondsSinceEpoch.toString()).
                                        set({
                                          "task": "${userTask[index]["task"]}",
                                          "status": "Completed",

                                        });
                                      },
                                      child: Text(
                                        "TASK COMPLETE",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),






                        ],

                    ),
                    );
                  }
              )




    );
  }

  Future getDocs() async {

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("task").get();
    final userDetails = querySnapshot;
    userDetails.docs.forEach((element) { //map through each item in the task collection
      List<dynamic> members = element.get("members"); // Take member list from the collection task
      members.forEach((mbrElement) {// take member map/dictionary that contains name and email

        var newEmail = mbrElement["email"]; // take email from the dictionary
        if (userEmail == newEmail) {//check whether the current user email matches with any email from the task collection
          List<String> memberNames = [];
          Map<String, dynamic> userTaskMap = {};
          setState(() {
            members.map((e) {
              memberNames.add(e["name"]);
            }).toList();
            userTaskMap["task"] = element["task-name"];
            userTaskMap["department"] = element["department"];
            userTaskMap["members"] = memberNames;
            userTaskMap["start"] = element["start-date"];
            userTaskMap["end"] = element["end-date"];
            userTask.add(userTaskMap);//add the task name which matches the email to a temporary list
          });
        }
      });

    });
  }
}