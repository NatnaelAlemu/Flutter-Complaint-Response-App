import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/Blocs/sign_up/sign_up_bloc.dart';
import 'package:frontend/customWidgets/widgets.dart';
import 'package:frontend/models/models.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  String? _role = "";
  void showAlert(BuildContext context, AlertType alertType, String desc) {
    Alert(context: context, type: alertType, title: "Signup", desc: desc)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: ListView(
              children: [
                SizedBox(height: 100),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormTextField(
                        obscureText: false,
                        controller: emailController,
                        hintText: "Email",
                        prefix: Icon(Icons.email),
                        whenEmpty: "this field is required",
                      ),
                      FormTextField(
                        controller: usernameController,
                        hintText: "Username",
                        whenEmpty: "this field is required",
                        prefix: Icon(Icons.person),
                      ),
                      FormTextField(
                        controller: passwordController,
                        hintText: "Password",
                        whenEmpty: "this field is required",
                        prefix: Icon(Icons.password),
                      ),
                      FormTextField(
                        obscureText: false,
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        prefix: Icon(Icons.password),
                        whenEmpty: "this field is required",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text("Complainant"),
                              Radio<String>(
                                value: "complainant",
                                groupValue: _role,
                                onChanged: (String? value) {
                                  setState(() {
                                    _role = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Admin"),
                              Radio<String>(
                                value: "admin",
                                groupValue: _role,
                                onChanged: (String? value) {
                                  setState(() {
                                    _role = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      BlocConsumer<SignUpBloc, SignUpState>(
                        listener: (context, state) {
                          if (state is SignedUp) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                                content: Text(
                                  "Signup success",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Pacifico', fontSize: 20),
                                ),
                              ),
                            );
                            // showAlert(context, AlertType.success, "Sucess");
                            Navigator.pushNamed(context, '/');
                          }
                          if (state is SignUpFailed) {
                            showAlert(context, AlertType.error, "Failed");
                          }
                        },
                        builder: (context, state) {
                          if (state is SignUpInitial) {
                            return Hero(
                              tag: "auth",
                              child: FormButton(
                                color: Colors.pinkAccent,
                                buttonLabel: "Sign up",
                                onpressed: () {
                                  final form = _formKey.currentState;
                                  if (form!.validate()) {
                                    form.save();
                                    BlocProvider.of<SignUpBloc>(context).add(
                                      SignUp(
                                        user: User(emailController.text,
                                            passwordController.text,
                                            fullName: "Dawit",
                                            userName: usernameController.text,
                                            confirmPassword:
                                                confirmPasswordController.text,
                                            role: _role),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }
                          if (state is SigningUp) {
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
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is SignUpInitial) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Already have account",
                              style: Theme.of(context).textTheme.headline5),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login Here",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
