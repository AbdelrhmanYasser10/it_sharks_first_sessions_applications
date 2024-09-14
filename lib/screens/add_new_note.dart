import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/cubit/database_cubit.dart';
import 'package:it_sharks_first_app/model/note_model.dart';

import '../utils/widgets/my_textformfield.dart';

class AddNewNote extends StatefulWidget {
  const AddNewNote({super.key});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new Note",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyTextFormField(
              hint: "Title",
              icon: const Icon(
                Icons.edit,
              ),
              controller: _titleController,
            ),
            MyTextFormField(
              hint: "Description",
              icon: Icon(
                Icons.edit,
              ),
              controller: _descriptionController,
            ),
            MyTextFormField(
              hint: "Date",
              icon: Icon(
                Icons.date_range,
              ),
              controller: _dateController,
            ),
            BlocConsumer<DatabaseCubit,DatabaseState>(
              listener: (context, state) {
                if(state is InsertNoteSuccessfully){
                  DatabaseCubit.get(context).getAllData();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                var cubit  = DatabaseCubit.get(context);
                return state is InsertNoteLoading ? const Center(
                  child:CircularProgressIndicator()
                ):ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: Colors.red),
                  onPressed: () {
                    NoteModel note = NoteModel(
                        title: _titleController.text,
                        desc: _descriptionController.text,
                        date: _dateController.text,
                        status: 0,
                    );
                    cubit.insertNewNote(note);
                  },

                  child: const Text(
                    "+Add",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
