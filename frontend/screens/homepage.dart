import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/customWidgets/widgets.dart';
import 'package:frontend/models/loginInModel.dart';

import 'screens.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Homepage extends StatelessWidget {
  static const String routName = "/homePage";
  Homepage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint App'),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                radius: 100,
                child: Text(
                  "Wellcome",
                  style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Complaint <=> Response App",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
              ),
              SizedBox(height: 10),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FormTextField(
                      prefix: Icon(Icons.email),
                      controller: emailController,
                      whenEmpty: "this field is required",
                      hintText: "Email",
                    ),
                    FormTextField(
                      obscureText: false,
                      prefix: Icon(Icons.password),
                      controller: passwordController,
                      whenEmpty: "this field is required",
                      hintText: "Password",
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginFailed) {
                          showAlert(context, AlertType.error, "Failed");
                        }
                        if (state is LoggedIn) {
                          if (state.user.role == "admin") {
                            Navigator.pushNamed(context, AdminScreen.routeName);
                          }
                          Navigator.pushNamed(
                              context, ComplaintScreen.routeName);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginInitial) {
                          return Column(
                            children: [
                              Hero(
                                tag: "auth",
                                child: FormButton(
                                  buttonLabel: "Login",
                                  color: Colors.blueAccent,
                                  onpressed: () {
                                    final form = formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      BlocProvider.of<LoginBloc>(context).add(
                                          Login(
                                              loginModel: LoginModel(
                                                  emailController.text,
                                                  passwordController.text)));
                                    }
                                  },
                                ),
                              ),
                              Text(
                                "If u don't have account",
                                style: TextStyle(
                                    fontFamily: 'Merienda', fontSize: 15),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SignupScreen.routeName);
                                },
                                child: Text(
                                  "Signup Here",
                                  style: TextStyle(
                                      fontFamily: 'Merienda',
                                      fontSize: 15,
                                      color: Colors.blue),
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is LoggingIn) {
                          return SpinKitSpinningLines(
                            color: Colors.deepPurple,
                            size: 60,
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void showAlert(BuildContext context, AlertType alertType, String desc) {
    Alert(context: context, type: alertType, title: "Login", desc: desc).show();
  }
}
