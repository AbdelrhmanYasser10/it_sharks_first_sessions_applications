import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/models/user_model.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context)=>BlocProvider.of(context);

  UserModel? userModel;

  void login({
  required String email,
    required String password,
})async{
    emit(LoginLoading());
    try{
      Response response = await DioHelper.postRequest(
          endPoint: "login",
          data: {
            "email":email,
            "password":password
          },
      );
      userModel = UserModel.fromJson(response.data);
      if(userModel!.status!){
        emit(LoginSuccessfully());
      }
      else{
        emit(LoginError());
      }
    }catch(error){
      emit(LoginError());
    }
  }
}
