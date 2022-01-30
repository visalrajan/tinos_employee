import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinos_employee/screens/signup_user/signup_user.dart';
import 'package:tinos_employee/screens/user_page/user_page.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var defaultEmail = "tinos@gmail.com";
  var defaultPassword = "12345678";

  static Future<User?> loginUsingEmailPassword(

      {
        required String email,
        required String password,
        required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "TINOS",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Text(
                "Username",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  // labelText: "User Name",
                  border: InputBorder.none,
                  hintText: "Your username here",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.teal,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal, width: 2),


              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            Container(
              child: Text(
                "Password",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your Password here",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.teal,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal, width: 2),

              ),
            ),
            const SizedBox(
              height: 70.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.teal,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                            strokeWidth: 6.0,
                          ),
                        );
                      });
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    if(defaultEmail == _emailController.text) {
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => SignupUser()));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupUser()));
                    }else{
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => UserPage()));
                    }
                  }

                },
                child: const Text(
                  "PROCEED",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
