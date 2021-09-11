class User {
  String? id;
  String? fullName;
  String? userName;
  String email;
  String password;
  String? confirmPassword;
  String? role;

  User(this.email, this.password,
      {this.fullName, this.id,this.userName, this.confirmPassword, this.role});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['email'], json['password'],
        fullName: json['fullName'],
        userName: json['username'],
        confirmPassword: json['confirmPassword'],
        role: json['role'],
        id: json['_id']);
  }
  Map<String,dynamic> toJson(){
    return {
      "fullName":fullName,
      "username":userName,
      "email":email,
      "password":password,
      "confirmPassword":confirmPassword,
      "role":role,
      "id":id 
    };
  }
}
