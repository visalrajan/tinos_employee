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

  void _showDatePicker(){
    showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value){
      setState(() {
        _dateTime = value!;
      });
    });
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  final item1 = ["Half Day","Full Day"];
  final item2 = ["Medical", "Casual"];
  String? valueChoose1;
  String? valueChoose2;

  TextEditingController reason = TextEditingController();
  final nameEditingController = TextEditingController();
  final departmentNameEditingController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late var uid =user?.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
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
                    Text("${_dateTime.day.toString()}:${_dateTime.month.toString()}:${_dateTime.year.toString()}",
                      style: TextStyle(fontSize: 20),
                    ),
                    MaterialButton(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Choose Date",
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
              SizedBox(
                height: 15,
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.teal, width: 2),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: TextFormField(
              //
              //       autofocus: false,
              //       controller: nameEditingController,
              //       keyboardType: TextInputType.name,
              //       validator: (value) {
              //         RegExp regex = new RegExp(r'^.{3,}$');
              //         if (value!.isEmpty) {
              //           return ("Name cannot be Empty");
              //         }
              //
              //         if (!regex.hasMatch(value)) {
              //           return ("Enter Valid Name(Min. 3 character)");
              //         }
              //         return null;
              //       },
              //       onSaved: (value){
              //         nameEditingController.text = value!;
              //       },
              //       textInputAction: TextInputAction.next,
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //
              //         prefixIcon: Icon(Icons.account_circle),
              //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              //         hintText: "Name",
              //
              //       ),
              //     ),
              //   ),
              // ),
              //
              // SizedBox(
              //   height: 20,
              // ),
              //
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.teal, width: 2),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: TextFormField(
              //
              //       autofocus: false,
              //       controller: departmentNameEditingController,
              //       keyboardType: TextInputType.name,
              //       validator: (value) {
              //         RegExp regex = new RegExp(r'^.{3,}$');
              //         if (value!.isEmpty) {
              //           return ("Department Name cannot be Empty");
              //         }
              //
              //         if (!regex.hasMatch(value)) {
              //           return ("Enter Valid Name(Min. 3 character)");
              //         }
              //         return null;
              //       },
              //       onSaved: (value){
              //         departmentNameEditingController.text = value!;
              //       },
              //       textInputAction: TextInputAction.next,
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //
              //         prefixIcon: Icon(Icons.work_outline_outlined),
              //         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              //         hintText: "Department Name",
              //
              //       ),
              //     ),
              //   ),
              // ),

              // SizedBox(
              //   height: 15,
              // ),


              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: SizedBox(),
                    iconSize: 36,
                    hint: Text("Half Day or Full Day"),
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
                padding: EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: SizedBox(),
                    iconSize: 36,
                    hint: Text("Select Type of Leave"),
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

              SizedBox(
                height: 15,
              ),


              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: reason,

                  minLines: 2,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type here your message",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                child: Text(
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
                        return Center(
                          child: Text("Leave Submit Successfull"),
                        );
                      });



                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Object? userEmail = "";
                  if (prefs.containsKey("email")) {
                    userEmail = prefs.get("email");
                  }


                  // FirebaseFirestore.instance.collection("leave").add({
                  //   "date":
                  //   "${_dateTime.day.toString()}:${_dateTime.month.toString()}:${_dateTime.year.toString()}",
                  //
                  //   "day-type":
                  //   "${valueChoose1.toString()}",
                  //   "leave-type":
                  //   "${valueChoose2.toString()}",
                  //   "reason":
                  //   "${reason.text.toString()}",
                  //   "name":
                  //   "${nameEditingController.text.toString()}",
                  //   "departmentName":
                  //   "${departmentNameEditingController.text.toString()}",
                  //
                  //
                  // });


                  FirebaseFirestore.instance.collection("leave").doc(DateTime.now().millisecondsSinceEpoch.toString()).
                  set({
                    "date":
                    "${_dateTime.day.toString()}:${_dateTime.month.toString()}:${_dateTime.year.toString()}",
                    "day-type":
                    "${valueChoose1.toString()}",
                    "leave-type":
                    "${valueChoose2.toString()}",
                    "reason":
                    "${reason.text.toString()}",
                    "email": userEmail
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
