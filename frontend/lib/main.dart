import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Blocs/login/login_bloc.dart';
import 'package:frontend/Blocs/sign_up/sign_up_bloc.dart';
import 'package:frontend/screens/routes.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'applicationStates/Blocs/sign_up/sign_up_bloc.dart';
import 'screens/homepage.dart';

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
      ],
      child: MaterialApp(
        title: "Compliant response app",
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}
