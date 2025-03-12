class CreateUserModel {
  String? name;
  String? email;
  String? password;
  String? uid;

  CreateUserModel({
    this.name,
    this.email,
    this.password,
    this.uid,

  });

  CreateUserModel.fromjson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    password = json?['pass'];
    uid = json?['uid'];

  }

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'email': email,
      'pass': password,
      'uid': uid,
    };
  }
}
