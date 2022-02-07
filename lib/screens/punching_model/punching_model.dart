import 'dart:convert';

class PunchingModels {

  List<PunchingModel>? datalist;
  PunchingModels({this.datalist});

  factory PunchingModels.fromjson (Map<String, dynamic> json){
    return PunchingModels(
      datalist: json["datalist"],
    );
  }

  Map<String, dynamic> toJson() => {
    "datalist": datalist,
  };
}

class PunchingModel {
   String? punchin;
   String? punchout;
   String? name;
   String? uid;
   String? email;

   PunchingModel({this.punchin, this.punchout, this.name, this.uid, this.email});

   factory PunchingModel.fromjson(Map<String, dynamic> json) {
     return PunchingModel(
       punchin: json["PunchIn"],
       punchout: json["PunchOut"],
       name: json["name"],
       uid: json["uid"],
       email: json["email"],
     );
   }
   Map<String, dynamic> tojson(){
     return
     {
       "PunchIn": punchin,
       "PunchOut": punchout,
       "name": name,
       "uid" : uid,
       "email" : email,

     };
   }

}
