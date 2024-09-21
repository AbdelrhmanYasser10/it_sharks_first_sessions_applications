import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/comment_model.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());
  List<CommentModel> allComments  = [];
  static CommentsCubit get(context)=>BlocProvider.of(context);
}
