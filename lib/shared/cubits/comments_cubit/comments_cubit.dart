import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:meta/meta.dart';

import '../../../models/comment_model.dart';
import '../../network/remote/endpoints/endpoints.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());
  List<CommentModel> allComments  = [];
  static CommentsCubit get(context)=>BlocProvider.of(context);

  void getAllComments(int postId) async{
    allComments = [];
    emit(GetCommentsLoading());
    try{
      Response response = await DioHelper.getRequest(
          endPoint: "$POSTS/$postId/comments",
      );
      if(response.statusCode == 200){
        response.data.forEach((element){
          allComments.add(CommentModel.fromJson(element));
        });
        emit(GetCommentsSuccessfully());
      }
      else{
        emit(GetCommentsError(message: "Response error"));
      }
    }catch(error){
      emit(GetCommentsError(message: "Internet error"));
    }

  }
}
