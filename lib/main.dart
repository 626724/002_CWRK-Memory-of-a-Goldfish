import 'package:amazon_clone/data/data.dart';
import 'package:amazon_clone/testpage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
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
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: const InitializaionScreen(),
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
  TextEditingController durationEditingController = TextEditingController();
  TextEditingController countEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/puzzle.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 4.55,
                ),
                Text(
                  "Please enter the url and press play ",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: height / 8,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: "Enter the url",
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: textEditingController,
                      onFieldSubmitted: (value) {
                        if (value.contains("goldfish")) {
                          fish = true;
                          points = 0;
                          moves = 0;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LandingPage();
                          }));
                        } else if (value.contains("elephant")) {
                          fish = false;
                          points = 0;
                          moves = 0;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LandingPage();
                          }));
                        } else {
                          textEditingController.clear();
                          textEditingController.text =
                              "Please Enter a valid URL";
                        }
                      },
                    ),
                  ),
                ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Container(margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey,
                //         blurRadius: 150.0,
                //         spreadRadius: 0,
                //         blurStyle: BlurStyle.outer,
                //       ),
                //     ],
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child:TextFormField(
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.all(10),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //       hintText: "Enter the duration you wish to see the tiles",
                //       hintStyle: TextStyle(color: Colors.black),
                //       fillColor: Colors.white,
                //       filled: true,
                //
                //     ),
                //     controller: durationEditingController,
                //     onFieldSubmitted: (value) {
                //       setState(() {
                //         duration = int.parse(value);
                //       });
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Container(margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey,
                //         blurRadius: 150.0,
                //         spreadRadius: 0,
                //         blurStyle: BlurStyle.outer,
                //       ),
                //     ],
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.all(10),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //       hintText: "Enter the countdown duration in minutes",
                //       hintStyle: TextStyle(color: Colors.black),
                //       fillColor: Colors.white,
                //       filled: true,
                //
                //     ),
                //     controller: countEditingController,
                //     onFieldSubmitted: (value) {
                //       setState(() {
                //         countdown = int.parse(value);
                //       });
                //     },
                //   ),
                // ),
                SizedBox(
                  height: height / 10,
                ),

                ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   duration = int.parse(durationEditingController.text);
                    // });
                    if (textEditingController.text.contains("goldfish")) {
                      fish = true;
                      points = 0;
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LandingPage();
                        }));
                      });
                    } else if (textEditingController.text
                        .contains("elephant")) {
                      fish = false;
                      points = 0;
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LandingPage();
                        }));
                      });
                    } else {
                      textEditingController.clear();
                      textEditingController.text = "Please Enter a valid URL";
                    }
                  },
                  child: Text("Play"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
  void initState() {
    // TODO: implement initState

   Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TestPage();
      }));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  fish ? "assets/background.jpg" : "assets/elephant.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                child: Text(
                  'Welcome to the game!\n'
                      'The tiles will be\n'
                      'shown for 1 minute!\n'
                      'for you to memorize them!\n'
                      'Enjoy the Game!\n',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/puzzle.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 20,
                  width: width / 4,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      },
                      child: Text("Play")),
                ),
                SizedBox(
                  height: height / 20,
                ),
                SizedBox(
                  height: height / 20,
                  width: width / 4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text("Exit"),
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

class InitializaionScreen extends StatefulWidget {
  const InitializaionScreen({Key? key}) : super(key: key);

  @override
  State<InitializaionScreen> createState() => _InitializaionScreenState();
}

class _InitializaionScreenState extends State<InitializaionScreen> {
  late VideoPlayerController _controller =
      VideoPlayerController.asset('assets/1.mp4',
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true,
          ))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
  @override
  void initState() {
    // TODO: implement initState
    _controller.play();
    Future.delayed(Duration(seconds: 7), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MenuPage();
      }));
    });
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}

class SecondVideo extends StatefulWidget {
  const SecondVideo({Key? key}) : super(key: key);

  @override
  State<SecondVideo> createState() => _SecondVideoState();
}

class _SecondVideoState extends State<SecondVideo> {
  late VideoPlayerController _controller2 =
      VideoPlayerController.asset('assets/2.mp4',
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true,
          ))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
  @override
  void initState() {
    // TODO: implement initState
    _controller2.play();
    _controller2.setLooping(true);
    // Future.delayed(Duration(seconds: 7), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return ThirdVideo();
    //   }));
    // });
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Stack(children: [
      Container(
        height: height,
        width: width,
        child: _controller2.value.isInitialized
            ? AspectRatio(
                aspectRatio: 0.5,
                child: VideoPlayer(_controller2),
              )
            : Container(),
      ),
      Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ThirdVideo();
            }));
          },
          child: Container(
            // color: Colors.blue,
            child: Image.asset("assets/playy.png"),
          ),
        ),
      ),
    ]);
  }
}

class ThirdVideo extends StatefulWidget {
  const ThirdVideo({Key? key}) : super(key: key);

  @override
  State<ThirdVideo> createState() => _ThirdVideoState();
}

class _ThirdVideoState extends State<ThirdVideo> {
  TextEditingController textEditingController = TextEditingController();
  late VideoPlayerController _controller3 =
      VideoPlayerController.asset('assets/3.mp4',
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true,
          ))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
  @override
  void initState() {
    // TODO: implement initState
    _controller3.play();
    _controller3.setLooping(true);
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFF11a89b),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              child: _controller3.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller3.value.aspectRatio,
                      child: VideoPlayer(_controller3),
                    )
                  : Container(),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(50),
                child: TextFormField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration.collapsed(
                      hintText: "Please Enter the URL here!"),
                  controller: textEditingController,
                  onFieldSubmitted: (value) {
                    if (value.contains("goldfish")) {
                      fish = true;
                      points = 0;
                      moves = 0;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Info();
                      }));
                    } else if (value.contains("elephant")) {
                      fish = false;
                      points = 0;
                      moves = 0;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Info();
                      }));
                    } else {
                      textEditingController.clear();
                      textEditingController.text = "Please Enter a valid URL";
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  // void initState() {
  //  // TODO: implement initState
  //   Future.delayed(Duration(seconds: 4), () {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return TestPage();
  //     }));
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset("assets/lottieani.zip")),
          Center(
          child: Container(
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontFamily: "Arima",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900
              ),

              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                      'Welcome to the game!\n'
                      'The tiles will be\n'
                      'shown for 1 minute!\n'
                      'for you to memorize them!\n'
                      'Enjoy the Game!\n',
                      speed: Duration(milliseconds: 100 )),
                ],
                isRepeatingAnimation: false,
                onTap: () {
                  print("Tap Event");
                },
                onFinished: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TestPage();
                  }));
                },
              ),
            ),
          ),
        ),]
      ),
    );
  }
}
// what does the confusion matrix record?
//Answer: It records the number of times the model predicted a certain class and the actual class was the same as the predicted class.