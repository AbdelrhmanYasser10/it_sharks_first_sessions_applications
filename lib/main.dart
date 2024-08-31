import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StackExample(),
    );
  }
}

// 30 - 8 - 2024
List<String> images = [
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/024/179/673/small_2x/pure-blue-sky-white-clouds-the-strong-light-through-the-clouds-shines-straight-on-the-endless-sea-of-white-tulip-flowers-ai-generative-photo.jpg",
];

List<String> names = [
  "Mohamed",
  "Abdelrahman",
  "Steven",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
  "Mahmoud",
];
class ListViewExample extends StatelessWidget {
  const ListViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "IT-Sharks Flutter",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return contactCard(
                image: images[index],
                name: names[index],
            );
          },
          separatorBuilder: (context, index) {
          return Divider();
          },
          itemCount: names.length,
      ),
    );
  }

  Padding contactCard({
  required String image,
  required String name,
}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                image
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            name,
          ),
        ],
      ),
    );
  }
}

class StackExample extends StatelessWidget {
  const StackExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 300,
                height: 500,
                color: Colors.red,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.yellow,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// 30 - 8 - 2024
class DiceScreen extends StatefulWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {

  List<String> allImages = [
    "assets/images/dice1.png",
    "assets/images/dice2.png",
    "assets/images/dice3.png",
    "assets/images/dice4.png",
    "assets/images/dice5.png",
    "assets/images/dice6.png",
  ];
  int index1 = 0;
  int index2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Dice",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    index1 = Random().nextInt(6);
                    index2 = Random().nextInt(6);
                    setState(() {

                    });
                  },
                  child: Image.asset(allImages[index1]),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    index1 = Random().nextInt(6);
                    index2 = Random().nextInt(6);
                    setState(() {

                    });
                  },
                  child: Image.asset(
                    allImages[index2],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
