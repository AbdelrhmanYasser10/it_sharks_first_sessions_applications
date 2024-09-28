import 'package:flutter/material.dart';
import 'package:it_sharks_first_app/screens/home_screen/home_screen.dart';

import '../screens/categories_screen/categories_screen.dart';
import '../screens/search_screen/search_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int index = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {

          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
            label: "Categories"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
            label: "Search"
          ),
        ],
      ),
      body: screens[index],
    );
  }
}
