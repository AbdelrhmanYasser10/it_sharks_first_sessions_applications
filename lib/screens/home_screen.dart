import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_sharks_first_app/screens/messages_screen.dart';
import 'package:it_sharks_first_app/screens/register.dart';
import 'package:it_sharks_first_app/shared/cubit/app_cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getAllContacts();
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              title: const Text("All Users"),
              actions: [
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Register(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MessagesScreen(
                                  reciverUser: cubit.allUsers[index])));
                    },
                    child: userCard(
                      email: cubit.allUsers[index].email,
                      imageLink: cubit.allUsers[index].imageLink,
                      username: cubit.allUsers[index].username,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
                itemCount: cubit.allUsers.length,
              ),
            ),
          );
        },
      );
    });
  }

  Widget userCard({
    required String email,
    required String username,
    required String imageLink,
  }) {
    return Card(
      elevation: 10,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                radius: 44.0,
                backgroundImage: NetworkImage(imageLink),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
