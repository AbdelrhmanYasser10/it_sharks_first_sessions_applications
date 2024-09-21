part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class GetCommentsLoading extends CommentsState {}
final class GetCommentsSuccessfully extends CommentsState {}
final class GetCommentsError extends CommentsState {
  final String message;
  GetCommentsError({required this.message});
}
