import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/models/message_model.dart';
import 'package:meta/meta.dart';

import '../../../models/userModel.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  final _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<UserModel> allUsers = [];

  void getAllContacts() {
    emit(GetAllContactsLoading());
    _database.collection("users").snapshots().listen((event) {
      allUsers = [];
      for (var element in event.docs) {
        if (element.id != _auth.currentUser!.uid) {
          UserModel user = UserModel.fromJson(element.data());
          allUsers.add(user);
        }
      }
      emit(GetAllContactsSuccessfully());
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
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      allMessages = [];
      for (var element in event.docs) {
        allMessages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetAllContactsSuccessfully());
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
}
