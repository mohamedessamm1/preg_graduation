class AccountModel {
  String ?Id;
  String ?username;
  String ?email;
  Null ?phoneNumber;
  String? accountType;
  String ?createdAt;
  String? updatedAt;
  int ?iV;

  AccountModel(
      {this.Id,
        this.username,
        this.email,
        this.phoneNumber,
        this.accountType,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AccountModel.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    accountType = json['accountType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
