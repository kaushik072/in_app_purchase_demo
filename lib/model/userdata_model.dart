class UserDataModel {
  String? email;
  String? name;
  String? password;
  String? confirmedPassword;
  String? mobileNumber;
  Interest? interest;
  String? id;

  UserDataModel(
      {this.email,
      this.name,
      this.password,
      this.confirmedPassword,
      this.mobileNumber,
      this.interest,
      this.id});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    confirmedPassword = json['confirmed_password'];
    mobileNumber = json['phone'];
    interest =
        json['interest'] != null ? Interest.fromJson(json['interest']) : null;
    id = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['confirmed_password'] = confirmedPassword;
    data['phone'] = mobileNumber;
    if (interest != null) {
      data['interest'] = interest!.toJson();
    }
    data['name'] = name;
    data['userId'] = id;
    data['email'] = email;
    return data;
  }
}

class Interest {
  List<String>? subCategoryID;
  String? categoryID;

  Interest({this.subCategoryID, this.categoryID});

  Interest.fromJson(Map<String, dynamic> json) {
    subCategoryID = json['subCategoryID'].cast<String>();
    categoryID = json['categoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subCategoryID'] = subCategoryID;
    data['categoryID'] = categoryID;
    return data;
  }
}
