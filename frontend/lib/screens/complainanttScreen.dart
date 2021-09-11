import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/complaint/complaint_bloc.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens/screens.dart';

class ComplaintScreen extends StatefulWidget {
  static const String routeName = '/Complaint';
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  String? _chosenValue;
  int _page = 0;
  String routeName = AddComplaint.routeName;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var user = User('email', 'password');
    String token = "";
    var state = BlocProvider.of<LoginBloc>(context).state;
    if (state is LoggedIn) {
      user = state.user;
      token = state.token;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.notifications,
            //     size: 30,
            //   ),
            // ),
            PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      BlocProvider.of<LoginBloc>(context).add(
                        TrigerInitial(),
                      );
                      Navigator.pushNamed(context, '/');
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpAndUpdateScreen(
                              user: user, isUpdate: true, token: token),
                        ),
                      );
                      break;
                    case 3:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Are you shure?'),
                            action: SnackBarAction(
                              label: "yes",
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                  DeleteAccount(user, token),
                                );
                              },
                            )),
                      );

                      break;
                  }
                },
                offset: Offset(
                  1,
                  45,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xff757575),
                elevation: 10,
                icon: Icon(
                  Icons.person,
                  size: 40,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          "logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        "update Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text(
                        "delete Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ];
                }),
          ],
        ),
      ),
      drawer: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoggedIn) {
            return Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Text('Complaint response app'),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        size: 40,
                      ),
                      title: Text('fullname'),
                      subtitle: Text(state.user.fullName!),
                      trailing: Icon(Icons.more_vert),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('role'),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('close'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Drawer(
            child: Text("no logedin user"),
          );
        },
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
          Center(
            child: Text(
              "Complainant Dashboard",
              style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: [
          Icon(
            Icons.add,
            size: 30,
          ),
          Text("All",
              style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30)),
          Text(
            "Fixed",
            style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          print(index);
          setState(() {
            _page = index;
          });
          if (index == 0) {
            Navigator.pushNamed(context, AddComplaint.routeName);
          } else if (index == 1) {
            BlocProvider.of<ComplaintBloc>(context)
                .add(LoadAllMyComplaints(user.id!));
            Navigator.pushNamed(context, AllAndFixedComplaintScreen.routeName);
          } else {
            BlocProvider.of<ComplaintBloc>(context)
                .add(LoadFixedComplaints(user.id!));
            Navigator.pushNamed(context, AllAndFixedComplaintScreen.routeName);
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
