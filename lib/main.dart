import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/layout/main_layout.dart';
import 'package:it_sharks_first_app/screens/login_screen.dart';
import 'package:it_sharks_first_app/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:it_sharks_first_app/shared/network/local/cache_helper/cache_helper.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize some code natively
  await DioHelper.initializeDio();
  await SharedPreferencesHelper.init();
  runApp(
    MyApp(
      hasUser: SharedPreferencesHelper.getData(key: "token") != null,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasUser;
  const MyApp({super.key, required this.hasUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: hasUser ? MainLayout() : LoginScreen(),
      ),
    );
  }
}
