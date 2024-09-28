import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/shared/cubit/app_cubit.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';

import 'layout/main_layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize some code natively
  await DioHelper.initializeDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainLayout(),
      ),
    );
  }
}


