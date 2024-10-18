import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it_sharks_first_app/models/userModel.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context)=>BlocProvider.of(context);


  final _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;
  CroppedFile? finalImage;

  UserModel? userModel;

  void pickImage()async{
    image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      emit(PickedImageSuccessfully());
    }
    else{
      emit(PickedImageWithError());
    }
  }
  void cropImage()async{
    finalImage = await ImageCropper().cropImage(
      sourcePath: image!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
    emit(CroppedSuccesfully());
  }

  void register({
    required String email,
    required String username,
    required String password,
  }){
    emit(RegisterLoading());
    _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      _storage.ref(
        "UserImages"
      ).child(
        finalImage!.path.split("/").last
      ).putFile(
        File(
            finalImage!.path
        ),
      ).then((file){
        _storage.ref(
            "UserImages",
        ).child(
            finalImage!.path.split("/").last
        ).getDownloadURL().then((imageLink){
          UserModel user = UserModel(
            email: email,
            username: username,
            imageLink: imageLink,
            userId:value.user!.uid,
          );
          _database.
          collection("users")
          .doc(
            value.user!.uid,
          ).set(user.toMap()).then((value){
            emit(RegisterSuccess());
          }).catchError((error){
            emit(RegisterError());
          });
        }).catchError((err){
          emit(RegisterError());
        });
      }).catchError((error){
        emit(RegisterError());
      });
    }).catchError((error){
      emit(RegisterError());
    });
  }

  void login({required String email,required String password}){
    emit(LoginLoading());
    _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      _database
      .collection("users")
      .doc(value.user!.uid).get().
      then((element){
        userModel = UserModel.fromJson(element.data()!);
        emit(LoginSuccess());
      }).catchError((error){
        emit(LoginError());
      });
    }).catchError((error){
      emit(LoginError());
    });
  }
}
