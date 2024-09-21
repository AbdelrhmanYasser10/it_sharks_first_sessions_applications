part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class GetAllPostsLoading extends PostsState{}
class GetAllPostsSuccessfully extends PostsState{}
class GetAllPostsWithError extends PostsState{
  final String message;
  GetAllPostsWithError({required this.message});
}


class GetSpecificPostLoading extends PostsState{}
class GetSpecificPostSuccessfully extends PostsState{}
class GetSpecificPostWithError extends PostsState{
final String message;
GetSpecificPostWithError({required this.message});
}