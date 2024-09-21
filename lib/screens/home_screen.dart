import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/screens/post_screen.dart';
import 'package:it_sharks_first_app/shared/cubits/comments_cubit/comments_cubit.dart';
import 'package:it_sharks_first_app/shared/cubits/posts_cubit/posts_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PostsCubit.get(context);
          if (state is GetAllPostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAllPostsWithError) {
            return Center(
              child: Column(
                children: [
                  Text(
                    state.message,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Reload"),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0, // افقي
                vertical: 10.0, //رأسي
              ),
              child: ListView.separated(
                itemCount: cubit.allPosts.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20.0,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      cubit.getSpecificPostWithId(cubit.allPosts[index].id!);
                      CommentsCubit.get(context).getAllComments(cubit.allPosts[index].id!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              cubit.allPosts[index].title!,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Divider(),
                            Text(
                              cubit.allPosts[index].body!,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
