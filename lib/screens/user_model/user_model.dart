class UserModel {
  String? name;
  String? departmentName;
  String? email;

  UserModel({this.name, this.departmentName, this.email});

  // receiving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      departmentName: map['departmentName'],
      email: map['email'],
    );
  }

  // sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'departmentName': departmentName,
      'email': email,
    };
  }
}
