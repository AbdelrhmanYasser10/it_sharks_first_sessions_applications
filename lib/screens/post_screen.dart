import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/shared/cubits/comments_cubit/comments_cubit.dart';
import 'package:it_sharks_first_app/shared/cubits/posts_cubit/posts_cubit.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          BlocConsumer<PostsCubit,PostsState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              var cubit = PostsCubit.get(context);
              if(state is GetSpecificPostLoading || cubit.post == null){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(state is GetSpecificPostWithError){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                      ),

                    ],
                  ),
                );
              }
              else{
                return Center(
                  child: Text(
                    cubit.post!.title!,
                  ),
                );
              }
            },
          ),
          Divider(),
          Text(
            "All Comments",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          BlocConsumer<CommentsCubit,CommentsState>(
              builder: (context, state) {
                var cubit = CommentsCubit.get(context);
                if(state is GetCommentsLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is GetCommentsError){
                  return Center(
                    child: Text(
                      state.message,
                    ),
                  );
                }
                else{
                  return Expanded(
                    child: ListView.builder(
                        itemCount: cubit.allComments.length,
                        itemBuilder: (context, index) {
                          return Text(
                            cubit.allComments[index].name!,
                          );
                        },
                    ),
                  );
                }
              },
              listener: (context, state) {

              },
          ),
        ],
      ),
    );
  }
}
