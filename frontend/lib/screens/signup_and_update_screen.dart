import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/Blocs/sign_up/sign_up_bloc.dart';
import 'package:frontend/customWidgets/widgets.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/screens/homepage.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpAndUpdateScreen extends StatefulWidget {
  static const String routeName = '/signup';
  SignUpAndUpdateScreen(
      {Key? key, this.user, this.token, this.isUpdate = false})
      : super(key: key);
  final bool isUpdate;
  final User? user;
  final String? token;
  @override
  _SignUpAndUpdateScreenState createState() => _SignUpAndUpdateScreenState();
}

class _SignUpAndUpdateScreenState extends State<SignUpAndUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  String? _role = "";
  void showAlert(BuildContext context, AlertType alertType, String desc) {
    Alert(context: context, type: alertType, title: "Signup", desc: desc)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = widget.isUpdate;
    if (isUpdate) {
      emailController.text = widget.user!.email;
      usernameController.text = widget.user!.userName!;
      fullNameController.text = widget.user!.fullName!;
      _role = widget.user!.role;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Account" : "SignUp"),
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
                        obscureText: false,
                        controller: fullNameController,
                        hintText: "Full Name",
                        prefix: Icon(Icons.person_outline),
                        whenEmpty: "this field is required",
                      ),
                      FormTextField(
                        controller: usernameController,
                        hintText: "Username",
                        whenEmpty: "this field is required",
                        prefix: Icon(Icons.person),
                      ),
                      FormTextField(
                        obscureText:true,
                        controller: passwordController,
                        hintText: "Password",
                        whenEmpty: "this field is required",
                        prefix: Icon(Icons.password),
                      ),
                      FormTextField(
                        obscureText: true,
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
                                buttonLabel:
                                    isUpdate ? "Update Account" : "Sign up",
                                onpressed: () {
                                  final form = _formKey.currentState;
                                  if (form!.validate()) {
                                    form.save();
                                    isUpdate
                                        ? BlocProvider.of<LoginBloc>(context)
                                            .add(
                                            UpdateAccount(
                                                User(emailController.text,
                                                    passwordController.text,
                                                    fullName:
                                                        fullNameController.text,
                                                    userName:
                                                        usernameController.text,
                                                    confirmPassword:
                                                        confirmPasswordController
                                                            .text,
                                                    role: _role,
                                                    id: widget.user!.id!),
                                                widget.token!),
                                          )
                                        : BlocProvider.of<SignUpBloc>(context)
                                            .add(
                                            SignUp(
                                              user: User(emailController.text,
                                                  passwordController.text,
                                                  fullName:
                                                      fullNameController.text,
                                                  userName:
                                                      usernameController.text,
                                                  confirmPassword:
                                                      confirmPasswordController
                                                          .text,
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
                isUpdate
                    ? BlocConsumer<LoginBloc, LoginState>(
                        listener: (contex, state) {
                        if (state is UpdateAccountSuccess) {
                          print("update event");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                "Account updated",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        }
                        if (state is DeleteAccountSuccess) {
                          print("delte event");

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                "Account Delted",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 20),
                              ),
                            ),
                          );
                          BlocProvider.of<LoginBloc>(context)
                              .add(TrigerInitial());
                          Navigator.pushNamed(context, Homepage.routName);
                        }
                      }, builder: (context, state) {
                        if (state is LoginCrudInProgress) {
                          return SpinKitSpinningLines(
                            color: Colors.deepPurple,
                            size: 60,
                          );
                        }
                        return Container();
                      })
                    : BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          if (state is SignUpInitial) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Already have account",
                                    style:
                                        Theme.of(context).textTheme.headline5),
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
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
