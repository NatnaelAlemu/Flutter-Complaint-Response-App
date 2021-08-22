import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/models/loginInModel.dart';
import 'package:frontend/screens/signup_screen.dart';
import 'package:frontend/widgets/widgets.dart';

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
              CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                radius: 100,
                child: Text(
                  "Wellcome",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Complain <=> Response App",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
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
                      obscureText: true,
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
                          // showAlert(context, AlertType.success, "Success goback and login");
                          Navigator.pushNamed(context, ComplaintScreen.routeName);
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
                              Text("if u don't have account",
                                  style: Theme.of(context).textTheme.headline5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, SignupScreen.routeName);
                                },
                                child: Text(
                                  "Signup Here",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.blue),
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is LoggingIn) {
                          return CircularProgressIndicator();
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
