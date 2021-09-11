import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/response/response_bloc.dart';
import 'package:frontend/screens/addresponse.dart';

class AllCommplaints extends StatelessWidget {
  const AllCommplaints({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/allcomplaints";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<ResponseBloc>(context).add(
              TriggerIntial(),
            );
            Navigator.pop(context);
          },
        ),
        title:
            BlocBuilder<ResponseBloc, ResponseState>(builder: (context, state) {
          if (state is FixedComplaintsLoaded) {
            return Text("Fixed complaints");
          } else
            return Text("All Complaints");
        }),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<ResponseBloc, ResponseState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FixedComplaintsLoaded) {
              return state.fixedcomplaints.length == 0
                  ? Center(
                      child: Text(
                        "No Fixed Complaints",
                        style: TextStyle(
                            fontFamily: 'PatrickHand',
                            fontSize: 30,
                            color: Colors.deepOrange),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.fixedcomplaints.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                      color:Colors.grey,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(20),
                                      ),),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Complaint",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                fontSize:30,
                                                color: Colors.deepOrange,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "Title",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                fontSize: 20,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "${state.fixedcomplaints[index]['_doc']['title']}",
                                            style: TextStyle(
                                              fontSize: 16,
                                                fontFamily: 'PatrickHand'),
                                          ),
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                fontSize: 20,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "${state.fixedcomplaints[index]['_doc']['description']}",
                                            style: TextStyle(
                                              fontSize: 16,
                                                fontFamily: 'PatrickHand'),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "By ${state.fixedcomplaints[index]['name']}",
                                          style: TextStyle(
                                              fontFamily: 'Merienda',
                                              color: Colors.deepPurple,
                                              backgroundColor:
                                                  Colors.lightBlue),
                                        )
                                      ],
                                    ),
                                    Text(
                                            "Response",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                fontSize:30,
                                                color: Colors.greenAccent,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "Title",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "${state.fixedcomplaints[index]['response']['title']}",
                                            style: TextStyle(
                                                fontFamily: 'PatrickHand'),
                                          ),
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "${state.fixedcomplaints[index]['response']['description']}",
                                            style: TextStyle(
                                                fontFamily: 'PatrickHand'),
                                          )
                                        ],
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddResponse(
                                                title:
                                                    state.fixedcomplaints[index]
                                                        ['_doc']['title'],
                                                description:
                                                    state.fixedcomplaints[index]
                                                        ['_doc']['description'],
                                                complaintId:
                                                    state.fixedcomplaints[index]
                                                        ['_doc']['_id'],
                                                responseTitle: state.fixedcomplaints[index]['response']['title'],
                                                responseDescription: state.fixedcomplaints[index]['response']['description'],
                                                responseId: state.fixedcomplaints[index]['response']['_id'],
                                                isUpdate: true,
                                                
                                          ),
                                          ),
                                        );
                                      },
                                      child: Text("Update"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.yellow),
                                    )
                              ],
                            ),
                          ),
                        );
                      });
            }
            if (state is AllComplaintsLoaded) {
              return state.allcomplaints.length == 0
                  ? Center(
                      child: Text(
                        "No new Complaints",
                        style: TextStyle(
                            fontFamily: 'PatrickHand',
                            fontSize: 30,
                            color: Colors.deepOrange),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.allcomplaints.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Title",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "${state.allcomplaints[index]['_doc']['title']}",
                                            style: TextStyle(
                                                fontFamily: 'PatrickHand'),
                                          ),
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                                fontFamily: 'Merienda',
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                            "${state.allcomplaints[index]['_doc']['description']}",
                                            style: TextStyle(
                                                fontFamily: 'PatrickHand'),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "By ${state.allcomplaints[index]['name']}",
                                          style: TextStyle(
                                              fontFamily: 'Merienda',
                                              color: Colors.deepPurple,
                                              backgroundColor:
                                                  Colors.lightBlue),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddResponse(
                                                title:
                                                    state.allcomplaints[index]
                                                        ['_doc']['title'],
                                                description:
                                                    state.allcomplaints[index]
                                                        ['_doc']['description'],
                                                complaintId:
                                                    state.allcomplaints[index]
                                                        ['_doc']['_id']),
                                          ),
                                        );
                                      },
                                      child: Text("fix issue"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.deepPurple),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
            }
            return Container(
              child: Text("Error happended"),
            );
          },
        ),
      ),
    );
  }
}
