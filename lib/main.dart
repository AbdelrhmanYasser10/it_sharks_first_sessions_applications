import 'package:flutter/cupertino.dart';
import 'package:it_sharks_first_app/database_helper/database_helper.dart';
import 'package:it_sharks_first_app/model/note_model.dart';

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
  NoteModel note1 = NoteModel.fromMap(await DatabaseHelper.getSpecificRow(1));
  note1.title = "title2";
  note1.desc = "dhgushgudhgsigbdsbcxvisugdsgjnsdgushge";
  note1.date = "8-9-2024";
  await DatabaseHelper.updateData(note1.toMap(), note1.id!);
  print(await DatabaseHelper.getSpecificRow(1));
}

