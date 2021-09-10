import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/Blocs/complaint/complaint_bloc.dart';
import 'package:frontend/customWidgets/formButton.dart';

class AllAndFixedComplaintScreen extends StatefulWidget {
  static const String routeName = '/allAndFixedComplaint';
  const AllAndFixedComplaintScreen({Key? key}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<AllAndFixedComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Complaints",
          style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
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
          BlocBuilder<ComplaintBloc, ComplaintState>(
            builder: (context, state) {
              if (state is ComplaintsLoading) {
                return Center(
                  child: SpinKitSpinningLines(
                    color: Colors.deepPurple,
                    size: 50,
                  ),
                );
              }
              if (state is FailedComplaintsCrud) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
                  ),
                );
              }
              if (state is AllMyFixedComplaintsLoaded) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: state.allmyfixedcomplaints.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height/1.8,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),

                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Response",
                                        style: TextStyle(
                                            decoration:
                                              TextDecoration.underline,
                                            fontFamily: 'PatrickHand',
                                            fontSize: 30,
                                            color: Colors.deepPurple),
                                      ),
                                      Text(
                                        "Title: ${state.allmyfixedcomplaints[index]['response']['title']}",
                                        style: TextStyle(
                                            fontFamily: 'PatrickHand',
                                            fontSize: 25,
                                            color: Colors.deepPurple),
                                      ),
                                      Text(
                                        "Description: ${state.allmyfixedcomplaints[index]['response']['description']}",
                                        style: TextStyle(
                                            fontFamily: 'PatrickHand',
                                            fontSize: 20,
                                            color: Colors.deepOrange),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Complaint",
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontFamily: 'PatrickHand',
                                            fontSize: 30,
                                            color: Colors.deepPurple),
                                      ),
                                      Text(
                                        "Title: ${state.allmyfixedcomplaints[index]['complaint']['title']}",
                                        style: TextStyle(
                                            fontFamily: 'PatrickHand',
                                            fontSize: 25,
                                            color: Colors.deepPurple),
                                      ),
                                      Text(
                                        "Description: ${state.allmyfixedcomplaints[index]['complaint']['description']}",
                                        style: TextStyle(
                                            fontFamily: 'PatrickHand',
                                            fontSize: 20,
                                            color: Colors.deepOrange),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: FormButton(
                                        color: Colors.greenAccent,
                                        buttonLabel: "Back",
                                        onpressed: () {
                                          Navigator.pop(context);
                                        })),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              if (state is AllMyComplaintsLoaded) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: state.allmycomplaints.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${state.allmycomplaints[index]['title']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'PatrickHand',
                                    fontSize: 30,
                                    color: Colors.deepPurple),
                              ),
                              Text(
                                state.allmycomplaints[index]['description'],
                                style: TextStyle(
                                    fontFamily: 'PatrickHand',
                                    fontSize: 20,
                                    color: Colors.deepOrange),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: FormButton(
                                          color: Colors.greenAccent,
                                          buttonLabel: "Back",
                                          onpressed: () {
                                            Navigator.pop(context);
                                          })),
                                  Expanded(
                                      child: FormButton(
                                          color: Colors.yellowAccent,
                                          buttonLabel: "update",
                                          onpressed: () {})),
                                  Expanded(
                                      child: FormButton(
                                          color: Colors.redAccent,
                                          buttonLabel: "one",
                                          onpressed: () {})),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Center(
                child: Text(
                  "Something wrong happened",
                  style: TextStyle(
                      fontFamily: 'PatrickHand',
                      fontSize: 30,
                      color: Colors.redAccent),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
