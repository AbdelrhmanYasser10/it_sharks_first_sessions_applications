import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/app_cubit.dart';
import '../../shared/utlis/card_component.dart';

class ResultsScreen extends StatelessWidget {
  final String category;
  const ResultsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is GetResultsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is GetResultsError){
            return const Center(
              child: Text(
                "Error While getting results",
              ),
            );
          }
          else{
            var cubit = AppCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CardComponent(article: cubit.resultsData!.articles![index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20.0,
                  );
                },
                itemCount: cubit.resultsData!.articles!.length,
              ),
            );
          }
        },
      ),
    );
  }
}
