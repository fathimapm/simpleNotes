class UserModel {
  final String email;
  final String? password;
  final String name;
  final String mobileNo;
  String? id;

  UserModel({required this.email, this.password, required this.name,required this.mobileNo, this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      name: json["name"],
      mobileNo: json["mobileNo"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "name": this.name,
      "mobileNo": this.mobileNo,
      "id": this.id,
    };
  }
//
}