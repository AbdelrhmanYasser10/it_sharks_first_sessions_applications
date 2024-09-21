import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/shared/cubits/posts_cubit/posts_cubit.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: BlocConsumer<PostsCubit,PostsState>(
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
    );
  }
}
