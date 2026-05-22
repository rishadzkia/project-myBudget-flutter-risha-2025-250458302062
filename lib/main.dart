import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/auth/bloc/login/login_bloc.dart';
import 'package:my_budget/auth/bloc/register/register_bloc.dart';
import 'package:my_budget/auth/pages/splash_screen.dart';
import 'package:my_budget/data/remote/auth_remote_datasource.dart';

void main() {
  runApp(const MainApp());
} 

class MainApp extends StatelessWidget {
  const MainApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => RegisterBloc(AuthRemoteDatasource())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyBudget',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF001E3A),
            background: Color(0xFF094174),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
