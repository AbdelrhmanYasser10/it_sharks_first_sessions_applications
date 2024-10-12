import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_sharks_first_app/layout/main_layout.dart';
import 'package:it_sharks_first_app/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:it_sharks_first_app/shared/network/local/cache_helper/cache_helper.dart';

import '../shared/styles/colors.dart';
import '../shared/styles/textStyles.dart';
import '../shared/widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOGIN",
                      style: AppTextStyle.titleStyle(),
                    ),
                    Text(
                      "welcome to our salla application",
                      style: AppTextStyle.subTitle(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MyTextFormField(
                      controller: _emailController,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      validator: (value) {
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (!emailValid) {
                          return "This is invalid email";
                        }
                        return null;
                      },
                      hintTxt: "E-mail",
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    MyTextFormField(
                      controller: _passwordController,
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                      ),
                      validator: (p0) {},
                      isPassword: true,
                      hintTxt: "Password",
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        var cubit = AuthCubit.get(context);

                        if (state is LoginSuccessfully) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text("Welcome to our app"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          SharedPreferencesHelper.saveData(
                              key:"token" ,
                              value: cubit.userModel!.data!.token,
                          ).then((value) {
                            if(value){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MainLayout()),
                                    (route) => false,
                              );
                            }
                          }).catchError((error){

                          });
                          /*try {
                            bool savedInCache = await SharedPreferencesHelper
                                .saveData(
                              key: "token",
                              value: cubit.userModel!.data!.token,
                            );
                            if (savedInCache) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (_) => MainLayout()
                                  ), (route) => false);
                            }
                          }catch(error){

                          }*/
                        }
                        if (state is LoginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Error while login to your account"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is LoginLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainBlack,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthCubit.get(context).login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainBlack,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: AppTextStyle.buttonTextStyle(),
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
