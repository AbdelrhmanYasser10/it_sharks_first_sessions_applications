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
      home: BMIApp(),
    );
  }
}

class BMIApp extends StatefulWidget {
  const BMIApp({Key? key}) : super(key: key);

  @override
  State<BMIApp> createState() => _BMIAppState();
}

class _BMIAppState extends State<BMIApp> {
  bool isMale = true;
  int height = 120;
  int weight = 70;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: genderCard(
                      imageLink: "assets/images/male.png",
                      text: "MALE",
                      function: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      activeBoolean: isMale,
                    ),
                  ),
                  Expanded(
                    child: genderCard(
                        imageLink: "assets/images/female.png",
                        text: "FEMALE",
                      function: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      activeBoolean: !isMale,
                    ),
                  ),
                ],
              ),
          ),
          Expanded(
            flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "HEIGHT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "$height",
                            style: TextStyle(
                              fontSize: 48,
                              color: Colors.white
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0,
                            ),
                            child: Text(
                              "cm",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),

                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: height.toDouble(),
                        min: 100,
                        max: 220,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            height = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ),
          Expanded(
            flex: 3,
              child: Container(
                color: Colors.yellow,
              ),
          ),
          Expanded(
              child: MyButton(
                text: "CALCULATE",
                onPressed: (){
                  double finalResult =  weight / ((height  / 100) * (height / 100));
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return ResultScreen(
                          result: finalResult,
                        );
                      }),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }

  Widget genderCard({
  required String imageLink,
  required String text,
  required VoidCallback function,
  required bool activeBoolean,
}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:activeBoolean? Colors.deepPurple.shade50 : Colors.deepPurple.shade500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    imageLink,
                    color:activeBoolean? Colors.black : Colors.white,
                  ),
                ),
                 Text(
                  text,
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:activeBoolean? Colors.black : Colors.white,

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ResultScreen extends StatelessWidget {
  final double result;
  const ResultScreen({Key? key , required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}



class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const MyButton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.deepPurple.shade500,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

