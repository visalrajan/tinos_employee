import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tinos_employee/screens/homepage/homepage.dart';
import 'package:tinos_employee/screens/user_model/user_model.dart';

class SignupUser extends StatefulWidget {
  const SignupUser({Key? key}) : super(key: key);

  @override
  _SignupUserState createState() => _SignupUserState();
}

class _SignupUserState extends State<SignupUser> {
  // var defaultDepartment = "departmentName";

  final FirebaseAuth auth = FirebaseAuth.instance;

// registration with email and password

  final formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();
  final departmentNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  bool isProcessing = false;

  final item = ["FLUTTER", "NODE", "REACT", "PYTHON"];
  String? valueChoose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    controller: nameEditingController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("Name cannot be Empty");
                      }

                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Name(Min. 3 character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: DropdownButton(
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: const SizedBox(),
                      iconSize: 36,
                      hint: const Text("Select Your Department"),
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue as String?;
                        });
                      },
                      items: item.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    controller: passwordEditingController,
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                    },
                    onSaved: (value) {
                      passwordEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key_outlined),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    controller: confirmPasswordEditingController,
                    validator: (value) {
                      if (confirmPasswordEditingController.text !=
                          passwordEditingController.text) {
                        return "Password don't match";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      confirmPasswordEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key_outlined),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                  strokeWidth: 6.0,
                                ),
                              );
                            });
                        signUp(emailEditingController.text,
                            passwordEditingController.text);
                      },
                      child: const Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.name = nameEditingController.text;
    userModel.departmentName = valueChoose;

    if (valueChoose == "FLUTTER") {
      await firebaseFirestore
          .collection("flutterDep")
          .doc(user.uid)
          .set(userModel.toMap());
    } else if (valueChoose == "NODE") {
      await firebaseFirestore
          .collection("nodeDep")
          .doc(user.uid)
          .set(userModel.toMap());
    } else if (valueChoose == "PYTHON") {
      await firebaseFirestore
          .collection("pythonDep")
          .doc(user.uid)
          .set(userModel.toMap());
    } else if (valueChoose == "REACT") {
      await firebaseFirestore
          .collection("reactDep")
          .doc(user.uid)
          .set(userModel.toMap());
    }

    Fluttertoast.showToast(msg: "Account created succesfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
    // Navigator.of(context).pop();
  }
}
