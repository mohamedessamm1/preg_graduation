class MyDataModel {
  String? email;
  String? name;
  String? avatar;
  String? uid;
  bool? isOnline = false;

  MyDataModel({
    this.email,
    this.name,
    this.avatar,
    this.uid,
    this.isOnline,
  });

  MyDataModel.fromJson(Map<String, dynamic>? json) {
    email = json?['email'];
    name = json?['name'];
    avatar = json?['avatar'];
    uid = json?['uid'];
    isOnline = json?['isOnline'];
  }
}
