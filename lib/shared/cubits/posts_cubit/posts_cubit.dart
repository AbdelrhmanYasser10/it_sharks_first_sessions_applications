import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:meta/meta.dart';

import '../../../models/posts_model.dart';
import '../../network/remote/endpoints/endpoints.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
static PostsCubit get(context)=>BlocProvider.of(context);
  List<PostsModel> allPosts = [];

  void getAllPosts()async{
    emit(GetAllPostsLoading());
    try{
      Response response = await DioHelper.getRequest(
          endPoint: POSTS,
      );
      if(response.statusCode == 200){
        for(var element in response.data){
          PostsModel post = PostsModel.fromJson(element);
          allPosts.add(post);
        }
        emit(GetAllPostsSuccessfully());
      }
      else{
        //400 //500
        emit(GetAllPostsWithError(message: "Server response error"));
      }
    }catch(error){
      emit(GetAllPostsWithError(message: "Internet connection error"));
    }
  }

}
