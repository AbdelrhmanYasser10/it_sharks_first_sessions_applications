part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState{}
class LoginSuccessfully extends AuthState{}
class LoginError extends AuthState{}


class RegisterLoading extends AuthState{}
class RegisterSuccessfully extends AuthState{}
class RegisterError extends AuthState{}

