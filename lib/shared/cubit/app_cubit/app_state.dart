part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class GetAllContactsLoading extends AppState {}
final class GetAllContactsSuccessfully extends AppState {}

final class GetAllMessagesLoading extends AppState {}
final class GetAllMessagesSuccessfully extends AppState {}

final class SendMessageSuccessfully extends AppState {}

final class GetAddressLoading extends AppState {}
final class GetAddressSuccessfully extends AppState {}
final class GetAddressWithError extends AppState {
  final String message;
  GetAddressWithError({required this.message});
}

