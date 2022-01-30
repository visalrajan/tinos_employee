import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {

  DateTime _dateTime = DateTime.now();

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
                    hintText: "Type here your message",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),

                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                  FirebaseFirestore.instance.collection("leave").add({
                    "date":
                    "${_dateTime.day.toString()}:${_dateTime.month.toString()}:${_dateTime.year.toString()}",

                    "day-type":
                    "${valueChoose1.toString()}",
                    "leave-type":
                    "${valueChoose2.toString()}",
                    "reason":
                    "${reason.text.toString()}",

                  });

                  print("${valueChoose1.toString()}"
                      "${valueChoose2.toString()}"
                      "${reason.text.toString()}"
                  );


                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
