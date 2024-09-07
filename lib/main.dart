import 'package:flutter/cupertino.dart';
import 'package:it_sharks_first_app/database_helper/database_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // intialize some code natively
  await DatabaseHelper.initializeDatabase();
  /*await DatabaseHelper.insertNewRow(
      {
        "title":"New note",
        "desc" :"Some description for this note",
        "date":"7-9-2024",
        "status": 0,
      },
  );*/
  Map<String,dynamic> data = await DatabaseHelper.getSpecificRow(1);
  print(data);
}

