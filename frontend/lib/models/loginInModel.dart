class LoginModel {
  String email;
  String password;

  LoginModel(this.email, this.password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(json['email'], json['password']);
  }

  Map<String,dynamic> toJson(){
    return {
      "email":email,
      "password":password
    };
  }
}
