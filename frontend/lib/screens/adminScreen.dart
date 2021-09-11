import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/Blocs/response/response_bloc.dart';
import 'package:frontend/screens/allcomplaints.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = "/adminScreen";
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String? _chosenValue;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                    Navigator.pushNamed(context, "/accountsettings");
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
      )),
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
          return Container();
        },
      ),
      body: Center(
        child: Text(
          "Fix complaints",
          style: TextStyle(fontFamily: 'PatrickHand', fontSize: 25),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: [
          Text("New",
              style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30)),
          Text(
            "Fixed",
            style: TextStyle(fontFamily: 'PatrickHand', fontSize: 30),
          ),
        ],
        color: Colors.deepPurple,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
          if (index == 0) {
            BlocProvider.of<ResponseBloc>(context).add(GetAllComplaints());
            Navigator.pushNamed(context, AllCommplaints.routeName);
          } else if (index == 1) {
            print(index);
            BlocProvider.of<ResponseBloc>(context).add(GetFixedComplaints());
            Navigator.pushNamed(context, AllCommplaints.routeName);
          } else {}
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
