class UserModel {
  String? token;
  User? user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  String? id;
  String? username;
  String? accountType;

  User({this.id, this.username, this.accountType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    accountType = json['accountType'];
  }


}
