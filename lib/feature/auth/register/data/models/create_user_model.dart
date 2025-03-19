class CreateUserModel {
  String? name;
  String? email;
  String? password;
  String? uid;
  bool? dr=false;

  CreateUserModel({
    this.name,
    this.email,
    this.password,
    this.uid,
    this.dr,

  });

  CreateUserModel.fromjson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    password = json?['pass'];
    uid = json?['uid'];
    dr = json?['dr'];

  }

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'email': email,
      'pass': password,
      'uid': uid,
      'dr': dr,
    };
  }
}
