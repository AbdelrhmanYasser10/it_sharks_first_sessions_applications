part of 'database_cubit.dart';

@immutable
sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}

//Get all data states
class GetAllNotesLoading extends DatabaseState{}
class GetAllNotesSuccessfully extends DatabaseState{}
class GetAllNotesWithError extends DatabaseState{}

// Update note
class UpdateNoteLoading extends DatabaseState{}
class UpdateNoteSuccessfully extends DatabaseState{}
class UpdateNoteWithError extends DatabaseState{}

//Delete states
class DeleteNoteLoading extends DatabaseState{}
class DeleteNoteSuccessfully extends DatabaseState{}
class DeleteNoteWithError extends DatabaseState{}