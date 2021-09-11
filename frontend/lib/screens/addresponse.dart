import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/Blocs/response/response_bloc.dart';
import 'package:frontend/customWidgets/widgets.dart';
import 'package:frontend/models/response.dart';
import 'package:frontend/screens/screens.dart';

class AddResponse extends StatelessWidget {
  AddResponse(
      {Key? key,
      required this.title,
      required this.description,
      required this.complaintId,
      this.responseId,
      this.responseTitle = "",
      this.responseDescription = "",
      this.isUpdate = false})
      : super(key: key);
  static const String routeName = "/AddResponse";
  final _formKey = GlobalKey<FormState>();
  final String title;
  final String description;
  final String complaintId;
  final String? responseTitle;
  final String? responseDescription;
  final bool isUpdate;
  final String? responseId;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = responseTitle!;
      descriptionController.text = responseDescription!;
    }
    String _id = "";
    var loggedinState = BlocProvider.of<LoginBloc>(context).state;
    if (loggedinState is LoggedIn) {
      _id = loggedinState.user.id!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? "Response Update" : "Response submission",
          style: TextStyle(
              fontSize: 25, fontFamily: 'Merienda', color: Colors.deepPurple),
        ),
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
          ListView(children: [
            SizedBox(height: MediaQuery.of(context).size.height / 3),
            Text(
              "Complaint was",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Merienda',
                color: Colors.lightGreen,
              ),
            ),
            Column(children: [
              Text(
                "Title",
                style: TextStyle(
                    fontFamily: 'Merienda',
                    decoration: TextDecoration.underline),
              ),
              Text(
                "$title",
                style: TextStyle(fontFamily: 'PatrickHand'),
              ),
              Text(
                "Description",
                style: TextStyle(
                    fontFamily: 'Merienda',
                    decoration: TextDecoration.underline),
              ),
              Text(
                "${description}",
                style: TextStyle(fontFamily: 'PatrickHand'),
              )
            ]),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                isUpdate ? "Update Response" : "Submit Your Response",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Merienda',
                  color: Colors.lightGreen,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(children: [
                FormTextField(
                  obscureText: false,
                  controller: titleController,
                  hintText: "title",
                  prefix: Icon(Icons.title),
                  whenEmpty: "this field is required",
                ),
                FormTextField(
                  controller: descriptionController,
                  hintText: "description",
                  whenEmpty: "this field is required",
                  prefix: Icon(Icons.description),
                ),
                FormButton(
                  color: Colors.deepPurple,
                  buttonLabel: "Submit",
                  onpressed: () {
                    var form = _formKey.currentState;
                    if (form!.validate()) {
                      var response = isUpdate
                          ? Response(
                              titleController.text,
                              descriptionController.text,
                              _id,
                              complaintId,
                              id: responseId!,
                            )
                          : Response(
                              titleController.text,
                              descriptionController.text,
                              _id,
                              complaintId,
                            );
                      isUpdate
                          ? BlocProvider.of<ResponseBloc>(context).add(UpdateResponse(response))
                          : BlocProvider.of<ResponseBloc>(context)
                              .add(CreateResponse(response));
                    }
                  },
                ),
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            BlocConsumer<ResponseBloc, ResponseState>(
                listener: (contex, state) {
              if (state is ResponseCrudSucess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                    content: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 20),
                    ),
                  ),
                );
                titleController.text = "";
                descriptionController.text = "";
                Navigator.pushNamed(context, AdminScreen.routeName);
              }
            }, builder: (_, state) {
              if (state is ResponseCrudInProgress) {
                return SpinKitSpinningLines(
                  color: Colors.deepPurple,
                  size: 60,
                );
              }
              if (state is ResponseCrudFailed) {
                return Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                );
              }
              return Container();
            }),
          ]),
        ],
      ),
    );
  }
}
