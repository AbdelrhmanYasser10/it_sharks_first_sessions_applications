import 'package:flutter/material.dart';
import 'package:it_sharks_first_app/screens/results_screen/results_screen.dart';
import 'package:it_sharks_first_app/shared/cubit/app_cubit.dart';

import '../../shared/constants/constants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              AppCubit.get(context).getResults(
                  category: titles[index].toLowerCase(),
              );
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ResultsScreen(category: titles[index])));
            },
            child: cardComponent(
                category: titles[index],
                icon:icons[index],
            ),
          );
        },
        itemCount: 6,
      ),
    );
  }

  Widget cardComponent({
    required String category,
    required IconData icon,
  }) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 72,
          ),
          const SizedBox(height: 5,),
          Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
