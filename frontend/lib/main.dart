import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/complaint/complaint_bloc.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/Blocs/response/response_bloc.dart';
import 'package:frontend/Blocs/sign_up/sign_up_bloc.dart';
import 'package:frontend/dataproviders/complaint.dart';
import 'package:frontend/repositories/complaint.dart';
import 'package:frontend/screens/routes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ComplaintBloc(
            repository: ComplaintRepository(
              complaintDataProvider: ComplaintDataProvider(),
            ),
          ),
        ),
        BlocProvider(
          create: (context)=>ResponseBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Compliant response app",
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}
