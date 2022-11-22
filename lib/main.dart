import 'package:amazon_clone/data/data.dart';
import 'package:amazon_clone/testpage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/tileModel.dart';

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
      title: 'Memory of Fish',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Memory of GoldFish", style: TextStyle(fontSize: 28, color: Colors.amberAccent),),
          SizedBox(
            height: height/8,
          ),
          Text(
            "Please enter the url and press enter ",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: height/10,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 150.0,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                ),
                controller: textEditingController,
                onFieldSubmitted: (value) {
                  if (value.contains("goldfish")) {
                    fish = true;

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TestPage();
                    }));
                  } else if (value.contains("elephant")) {
                    fish = false;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TestPage();
                    }));
                  }
                  else{
                    textEditingController.clear();
                    textEditingController.text = "Please Enter a valid URL";
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: DefaultTextStyle(
            style:  TextStyle(
              fontSize: 28,
              color: Colors.orange.shade300,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Memory of Goldfish'),
                WavyAnimatedText('Enjoy the Game!'),
              ],
              isRepeatingAnimation: false,
              pause: Duration(seconds: 2),
              onTap: () {
                print("Tap Event");
              },
              onFinished: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
            ),
          ),
        ),
      ),
    );
  }
}
