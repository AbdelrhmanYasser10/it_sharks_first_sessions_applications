import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:it_sharks_first_app/models/userModel.dart';
import 'package:it_sharks_first_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:latlong2/latlong.dart';

import 'map_screen.dart';

class MessagesScreen extends StatefulWidget {
  final UserModel reciverUser;
  const MessagesScreen({super.key, required this.reciverUser});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getAllMessage(widget.reciverUser.userId);
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.reciverUser.imageLink,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    widget.reciverUser.username,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      bool iAmSender = FirebaseAuth.instance.currentUser!.uid ==
                          cubit.allMessages[index].senderId;
                      return BubbleSpecialThree(
                        text: cubit.allMessages[index].content,
                        color: iAmSender
                            ? const Color(0xFF1B97F3)
                            : const Color(0xFFE8E8EE),
                        tail: false,
                        isSender: iAmSender,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10.0,
                      );
                    },
                    itemCount: cubit.allMessages.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Message cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter yout message ....",
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon:IconButton(
                                onPressed: ()async{
                                  if(await _handleLocationPermission()){
                                    Position currLocation = await Geolocator.getCurrentPosition();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return MapScreen(
                                              myLocation: LatLng(currLocation.latitude,currLocation.longitude ),
                                            );
                                          },
                                        ),
                                    );
                                  }
                                  else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MapScreen(
                                            myLocation: LatLng(30.3333,31.3333),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.sendMessage(
                                _controller.text,
                                widget.reciverUser.userId,
                              );
                              _controller.clear();
                            }
                          },
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}
