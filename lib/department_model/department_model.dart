import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DepartmentModel {
  String? name;
  String? departmentName;
  String? email;

  DepartmentModel ({this.name, this.email, this.departmentName});

  factory DepartmentModel.fromjson(Map<String, dynamic>json){
    return DepartmentModel(
        name : json["name"],
        departmentName: json["departmentName"],
      email: json["email"],
    );
  }
}
class UserDepartment {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  DepartmentModel model = DepartmentModel();
  Future <DepartmentModel>getdep() async{

    final data = await store.collection("flutterDep").doc(auth.currentUser!.uid).get().
    then((value) => DepartmentModel.fromjson(value.data()!) );
    return model = await data;

  }

}