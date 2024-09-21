import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/screens/home_screen.dart';
import 'package:it_sharks_first_app/shared/cubits/comments_cubit/comments_cubit.dart';
import 'package:it_sharks_first_app/shared/cubits/posts_cubit/posts_cubit.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize some code natively
  await DioHelper.initializeDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => PostsCubit()..getAllPosts(),
        ),
        BlocProvider(
            create: (context) => CommentsCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}


