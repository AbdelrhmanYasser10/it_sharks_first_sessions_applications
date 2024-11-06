import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/models/geocoding_model.dart';
import 'package:it_sharks_first_app/models/message_model.dart';
import 'package:it_sharks_first_app/shared/network/remote/endpoints.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../../../models/userModel.dart';
import '../../network/remote/dio_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  final _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<UserModel> allUsers = [];
  GeocodingModel? address;
  void getAllContacts() {
    emit(GetAllContactsLoading());
    _database.collection("users").snapshots().listen((event) {
      allUsers = [];
      for (var element in event.docs) {
        print(element.data());
        if (element.id != _auth.currentUser!.uid) {
          UserModel user = UserModel.fromJson(element.data());
          allUsers.add(user);
        }
      }
      emit(GetAllContactsSuccessfully());
    }).onError((erro) {
      print("here");
      print(erro);
    });
  }

  List<MessageModel> allMessages = [];
  void getAllMessage(String recId) {
    String myId = _auth.currentUser!.uid;
    emit(GetAllMessagesLoading());
    _database
        .collection("users")
        .doc(myId)
        .collection("chats")
        .doc(recId)
        .collection("message")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      allMessages = [];
      for (var element in event.docs) {
        print(element.data());
        allMessages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetAllMessagesSuccessfully());
    });
  }

  void sendMessage(String content, String recId) {
    String myId = _auth.currentUser!.uid;
    MessageModel message = MessageModel(
      senderId: myId,
      content: content,
      recId: recId,
      time: Timestamp.now(),
    );
    _database
        .collection("users")
        .doc(myId)
        .collection("chats")
        .doc(recId)
        .collection("message")
        .add(message.toMap())
        .then((value) {
      _database
          .collection("users")
          .doc(recId)
          .collection("chats")
          .doc(myId)
          .collection("message")
          .add(message.toMap())
          .then((value) {
        emit(SendMessageSuccessfully());
      });
    });
  }

  void getAddress(LatLng addressLatLng) {
    emit(GetAddressLoading());
    DioHelper.getRequest(
        endPoint: REVERSEGEOCODING,
      queryParameters: {
          "latitude":addressLatLng.latitude,
          "longitude":addressLatLng.longitude,
        "localityLanguage":"en",
      }
    ).then((value){
      // Server Side
      if(value.statusCode != 200){
        emit(GetAddressWithError(message: value.data["description"]));
      }
      else{
        //https://maps.google.com/?q=lat,long
        address = GeocodingModel.fromJson(value.data);
        emit(GetAddressSuccessfully());
      }
    }).catchError((error){
      // Client Side
      emit(GetAddressWithError(message: "Error, Check your address again"));

    });
  }
}
