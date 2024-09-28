part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}


class GetHomeDataLoading extends AppState{}
class GetHomeDataSuccessfully extends AppState{}
class GetHomeDataError extends AppState{}


class GetResultsLoading extends AppState{}
class GetResultsSuccesfully extends AppState{}
class GetResultsError extends AppState{}
