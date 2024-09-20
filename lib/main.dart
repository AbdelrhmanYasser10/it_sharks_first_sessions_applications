import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:it_sharks_first_app/shared/network/remote/endpoints/endpoints.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // intialize some code natively
  await DioHelper.initializeDio();
  Response response = await DioHelper.getRequest(endPoint: "");
  print(response.data);
  print(response.statusCode);
  print(response.statusMessage);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
