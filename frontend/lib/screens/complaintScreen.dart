import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/main.dart';

class ComplaintScreen extends StatelessWidget {
  static const String routeName = '/Complaint';
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Screen'),
      ),
      drawer: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if(state is LoggedIn){
          return Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text('Complaint response app'),
                  decoration: BoxDecoration(
                    color: Colors.red,
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
          );
          }
          return Drawer(child: Text("no logedin user"),);
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
        ],
      ),
    );
  }
}
