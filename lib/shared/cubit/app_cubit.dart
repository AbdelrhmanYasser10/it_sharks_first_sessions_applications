import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/models/news_model.dart';
import 'package:it_sharks_first_app/shared/constants/constants.dart';
import 'package:it_sharks_first_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:it_sharks_first_app/shared/network/remote/endpoints/endpoints.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  NewsModel? homeData;
  NewsModel? resultsData;
  void getHomeData() async {
    emit(GetHomeDataLoading());
    try {
      Response response =
          await DioHelper.getRequest(endPoint: TOPHEADLINES, queryParameters: {
        "apiKey": APIKEY,
        "country": "us",
      });
      homeData = NewsModel.fromJson(response.data);
      if (homeData!.status! == "ok") {
        emit(GetHomeDataSuccessfully());
      } else {
        emit(GetHomeDataError());
      }
    } catch (error) {
      emit(GetHomeDataError());
    }
  }
  void getResults({required String category})async{
    emit(GetResultsLoading());
    try{
      Response response = await DioHelper.getRequest(
          endPoint: TOPHEADLINES,
        queryParameters: {
            "apiKey":APIKEY,
            "country":"us",
            "category":category,
        }
      );
      resultsData = NewsModel.fromJson(response.data);
      if(resultsData!.status! == "ok"){
        emit(GetResultsSuccesfully());
      }
      else{
        emit(GetResultsError());
      }
    }catch(error){
      emit(GetResultsError());
    }
  }
}
