import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/database_helper/database_helper.dart';
import 'package:meta/meta.dart';

import '../model/note_model.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());

  static DatabaseCubit get(context)=>BlocProvider.of(context);

  List<NoteModel> allNotes = [];

  void getAllData() async{
    allNotes = [];
    emit(GetAllNotesLoading());
    try {
      List<Map<String, dynamic>> allData = await DatabaseHelper.getAllData();
      for (var element in allData) {
        NoteModel note = NoteModel.fromMap(element);
        allNotes.add(note);
      }
      emit(GetAllNotesSuccessfully());
    }catch(error){
      emit(GetAllNotesWithError());
    }
  }

  void updateSpecificNote(NoteModel updatedNote) async{
    emit(UpdateNoteLoading());
    try{
      await DatabaseHelper.updateData
        (updatedNote.toMap(), updatedNote.id!);
      emit(UpdateNoteSuccessfully());
    }
        catch(error){
      emit(UpdateNoteWithError());
        }
  }

  void deleteSpecificNote(int id)async{
    emit(DeleteNoteLoading());
    try{
      await DatabaseHelper.deleteData(id);
      emit(DeleteNoteSuccessfully());
    }
    catch(error){
      emit(DeleteNoteWithError());
    }
  }

  void insertNewNote(NoteModel note){}

  void getNote(int id){}

}
