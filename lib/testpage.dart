import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:amazon_clone/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'data/data.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

ConfettiController _controllerCenter =
    ConfettiController(duration: const Duration(seconds: 10));

class _TestPageState extends State<TestPage> {
  final CountdownController _controller = CountdownController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    absorbing = true;
    game_started = true;
    game_started = false;
       // _controllerCenterRight =
    //     ConfettiController(duration: const Duration(seconds: 10));
    // _controllerCenterLeft =
    //     ConfettiController(duration: const Duration(seconds: 10));
    // _controllerTopCenter =
    //     ConfettiController(duration: const Duration(seconds: 10));
    // _controllerBottomCenter =
    //     ConfettiController(duration: const Duration(seconds: 10));

    SystemChannels.lifecycle.setMessageHandler((msg) {
      debugPrint('SystemChannels> $msg');
      if (msg == AppLifecycleState.resumed.toString()) setState(() {});
      return Future.value('');
    });
    selected = true;
    getData();
    print(
        'This is our data                           ---------------------${getData()}');
    networkSelected = true;
    pairs = getPairs();
    var hello = getNetworkPairs();
    print("This is hello -----------*************************$hello");
    networkPairs = getNetworkPairs();
    print(networkPairs[0].getImageAssetPath());
    for (int i = 0; i <= networkPairs.length - 1; i++) {
      networkPairs[i].setIsSelected(true);
    }
    networkPairs.shuffle();
    pairs.shuffle();
    visiblePairs = pairs;
    visibleNetworkPairs = networkPairs;
    print('yo');
    print(networkImages);
    print(getNetworkQuestions());
    print(
        "-----------------------------------------------------------------------------------------------------------------------------------");
    Future.delayed(Duration(seconds: duration), () {
      setState(() {
        auto = true;
        _controller.start();
        game_started = false;
        absorbing = false;
        visiblePairs = getQuestions();
        visibleNetworkPairs = getNetworkQuestions();
        print(visibleNetworkPairs);
        selected = false;
        for (int i = 1; i <= networkPairs.length - 1; i++) {
          networkPairs[i].setIsSelected(false);
        }

        isVisible = true;

      });
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose

    // _controllerCenterRight.dispose();
    // _controllerCenterLeft.dispose();
    // _controllerTopCenter.dispose();
    // _controllerBottomCenter.dispose();
    super.dispose();
  }

  void setTileIndex(int index) {
    selectedTileIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                points != 2000
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${points.toString()}/2000 \n Points",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,  fontFamily: "Arima",),
                              ),
                        Visibility(
                          visible: isVisible,
                          child: ElevatedButton(
                            child: game_started?Text("Start Game"):Text("Pause Game"),
                            onPressed: () {
                              if (game_started == true) {
                                setState(() {

                                  game_started = false;
                                  _controller.start();
                                });
                              } else {
                                setState(() {

                                  game_started = true;
                                  _controller.pause();
                                });
                              }
                            },
                          ),
                        ),
                              Column(
                                children: [
                                  Countdown(

                                    controller: _controller,
                                    seconds: countdown,
                                    build: (_, double time) => Text(
                                      "Timer ${time.toInt().toString()} seconds",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Arima",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    interval: Duration(milliseconds: 100),
                                    onFinished: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Timer is done!'),
                                        ),
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CongratulationsPage()));
                                    },
                                  ),
                                  Text(moves.toString() + " Moves"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                points != 2000
                    ? Container(
                        child: networkPairs.isNotEmpty
                            ? GridView(
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 1.0),
                                children: List.generate(40, (index) {
                                  return networkPairs.isNotEmpty
                                      ? Tilee(
                                          imageAssetPath:
                                              visibleNetworkPairs[index]
                                                  .getImageAssetPath(),
                                          parent: this,
                                          tileIndex: index,
                                        )
                                      : CircularProgressIndicator();

                                  return Container();
                                }),
                              )
                            : CircularProgressIndicator(),
                      )
                    : CongratulationsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tilee extends StatefulWidget {
  Tilee({
    Key? key,
    required this.imageAssetPath,
    required this.parent,
    required this.tileIndex,
  }) : super(key: key);
  String imageAssetPath;

  int tileIndex;
  _TestPageState parent;
  @override
  State<Tilee> createState() => _TileeState();
}

class _TileeState extends State<Tilee> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontScale;
  late Animation<double> _backScale;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: GestureDetector(
        onTap: () {
          _controller.animateTo(3, curve: Curves.easeIn);
          _controller.reverse(from: 1.0);
          if (selectedImageURL != "") {
            _controller.animateBack(4, curve: Curves.easeIn);

            if (selectedImageURL ==
                networkPairs[widget.tileIndex].getImageAssetPath()) {
              //prevent clicking on the same tile
              if (selectedTileIndex == widget.tileIndex) {
                return;
              }

              //correct
              print(selectedImageURL);
              print(networkPairs[widget.tileIndex].getImageAssetPath());
              print("correct");
              selected = true;
              _controller.animateTo(3, curve: Curves.easeIn);
              _controller.reverse(from: 1.0);
              setState(() {
                moves = moves + 1;
              });

              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {});

                points = points + 100;

                selected = false;
                widget.parent.setState(() {
                  networkPairs[widget.tileIndex].setImageAssetPath("");
                  networkPairs[selectedTileIndex].setImageAssetPath("");
                });
              });
            } else {
              _controller.animateTo(3, curve: Curves.easeIn);
              _controller.reverse(from: 1.0);
              print("not correct");

              setState(() {
                moves = moves + 1;
              });
              selected = true;
              Future.delayed(const Duration(milliseconds: 200), () {
                selected = false;
                widget.parent.setState(() {
                  networkPairs[widget.tileIndex].setIsSelected(false);
                  networkPairs[selectedTileIndex].setIsSelected(false);
                });
              });
            }
            selectedImageURL = "";
          } else {
            selectedTileIndex = widget.tileIndex;
            selectedImageURL =
                networkPairs[widget.tileIndex].getImageAssetPath();
          }
          setState(() {
            networkPairs[widget.tileIndex].setIsSelected(true);
          });
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(pi * _frontScale.value),
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _backScale,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(pi * _backScale.value),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: networkPairs[widget.tileIndex].getImageAssetPath() !=
                          ""
                      ? selected &&
                              selectedTileIndex == widget.tileIndex &&
                              networkPairs[widget.tileIndex]
                                      .getImageAssetPath() !=
                                  ""
                          ? Image.network(
                              networkPairs[widget.tileIndex]
                                  .getImageAssetPath(),
                              fit: BoxFit.cover,
                            )
                          : networkPairs[widget.tileIndex].getIsSelected()
                              ? Image.network(
                                  networkPairs[widget.tileIndex]
                                      .getImageAssetPath(),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: fish ? Colors.blue : Colors.green,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            getNetworkQuestions()[0]
                                                .getImageAssetPath()),
                                      )),
                                )
                      : Transform.scale(
                          scaleX: -1,
                          child: RotatedBox(
                            quarterTurns: 4,
                            child: Container(
                              child: Image.asset("assets/correct.png"),
                            ),
                          ),
                        ),
                ),
              ),
            );
          },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: fish ? Colors.blue : Colors.green,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     margin: EdgeInsets.all(5),
          //     child: networkPairs[widget.tileIndex].getImageAssetPath() != ""
          //         ? CachedNetworkImage(
          //             fit: BoxFit.cover,
          //             // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //             //     CircularProgressIndicator(value: downloadProgress.progress),
          //             // errorWidget: (context, url, error) => Icon(Icons.error),
          //             imageUrl: networkPairs[widget.tileIndex].getIsSelected()
          //                 ? networkPairs[widget.tileIndex].getImageAssetPath()
          //                 : getNetworkQuestions()[0].getImageAssetPath(),
          //           )
          //         : Image.asset(
          //             "assets/correct.png",
          //             fit: BoxFit.cover,
          //           ),
          //   ),
        ),
      ),
    );
  }
}

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({Key? key}) : super(key: key);

  @override
  State<CongratulationsPage> createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF11a89b),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  points == 2000 ? "Congratulations" : "Game Over",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Arima",
                    decoration: TextDecoration.none,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  points == 2000 ? "You have completed the game" : "",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Arima",
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  points == 2000 ? "Your score is $points" : "Your score is $points",
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontFamily: "Arima",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  points == 2000 ? "You have made $moves moves" : "You have made $moves moves",
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontFamily: "Arima",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return InitializaionScreen();
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      "Replay",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ConfettiWidget(
                      shouldLoop: true,
                      confettiController: _controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      blastDirection: pi / 2,
                      emissionFrequency: 0.05,
                      numberOfParticles: 10,
                      gravity: 0.05,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      "Exit",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

class LostGame extends StatefulWidget {
  const LostGame({Key? key}) : super(key: key);

  @override
  State<LostGame> createState() => _LostGameState();
}

class _LostGameState extends State<LostGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You lost",
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // const Text(
              //   "You have completed the game",
              //   style: TextStyle(
              //     color: Colors.black,
              //     decoration: TextDecoration.none,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your score is $points",
                style: const TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "You have made $moves moves",
                style: const TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MenuPage();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    "Replay",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
