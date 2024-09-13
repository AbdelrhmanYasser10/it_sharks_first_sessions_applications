import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/cubit/database_cubit.dart';
import 'package:it_sharks_first_app/database_helper/database_helper.dart';
import 'package:it_sharks_first_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // intialize some code natively
  await DatabaseHelper.initializeDatabase();
  /*  //1 - get the specific query
    // هجيب الrow اللي انا محتاجه يتعدل
    Map<String ,dynamic> query1 = await DatabaseHelper.getSpecificRow(1);
    // 2 - convert the map to object
    // حول الماب اللي رجعت ل object عشان هيبقا سهل اعدل فيه
    NoteModel note1 = NoteModel.fromMap(query1);
    // 3 - تعديل في الobject اللي معايا
    note1.title = "sdkhsuhgudsgs";
    note1.desc = "fsdfsidgsdigsdjigd";
    note1.status = 1;
    // 4 - اعمل Save في الداتابيز
    await DatabaseHelper.updateData(note1.toMap(), note1.id!);*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseCubit()..getAllData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}


