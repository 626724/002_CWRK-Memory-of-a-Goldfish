import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'data/data.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = true;
    getData();
    print('This is our data                           ---------------------${getData()}');
    networkSelected= true;
    pairs = getPairs();
    getNetworkPairs();
    networkPairs = getNetworkPairs();
    print(networkPairs[0].getImageAssetPath());
    for (int i =0; i<=networkPairs.length-1;i++){
      networkPairs[i].setIsSelected(true);
    }
    networkPairs.shuffle();
    pairs.shuffle();
    visiblePairs = pairs;
    visibleNetworkPairs = networkPairs;
    print('yo');
    print(networkImages);
    print(getNetworkQuestions());
    print("-----------------------------------------------------------------------------------------------------------------------------------");

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        visiblePairs = getQuestions();
        visibleNetworkPairs = getNetworkQuestions();
        print(visibleNetworkPairs);
        selected = false;
        for (int i =1; i<=networkPairs.length -1;i++){
          networkPairs[i].setIsSelected(false);
        }
      });
    });
  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Container(
        // height: 1,
        width: width,
        // padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Test Page"),
              const SizedBox(
                height: 25,
              ),
              points != 2000
                  ? Column(
                children: [
                  Text(
                    "${points.toString()}/2000",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Text(
                    "Points",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              points != 800
                  ? Column(children: [
                SingleChildScrollView(
                  child: Container(
                    child: networkPairs.isNotEmpty?GridView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 1.0),
                      children: List.generate(40, (index) {
                          return networkPairs.isNotEmpty?Tilee(
                            imageAssetPath: visibleNetworkPairs[index].getImageAssetPath(),
                            parent: this,
                            tileIndex: index,
                          ):
                              CircularProgressIndicator();

                        return Container();
                      }),
                    ):
                        CircularProgressIndicator(),
                  ),
                ),
              ])
                  : GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Text(
                      "Replay",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 100,
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return TestPage();
              //     }));
              //   },
              //   child: Text("YO"),
              // ),
            ],
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

class _TileeState extends State<Tilee> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        if (!selected) {
          if (selectedImageURL != "") {
            if (selectedImageURL ==
                networkPairs[widget.tileIndex].getImageAssetPath()) {
              //correct
              print(selectedImageURL);
              print(networkPairs[widget.tileIndex].getImageAssetPath());
              print("correct");
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {});

                points = points + 100;

                selected = false;
                widget.parent.setState(() {
                  networkPairs[widget.tileIndex].setImageAssetPath("");
                  networkPairs[selectedTileIndex].setImageAssetPath("");
                });
              });
            } else {
              print("not correct");
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
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
        }
      },
      child: Container(
        color: Colors.blue,
        margin: EdgeInsets.all(5),
        child:
        networkPairs[widget.tileIndex].getImageAssetPath() != ""
            ? CachedNetworkImage(
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl: networkPairs[widget.tileIndex].getIsSelected()
              ? networkPairs[widget.tileIndex].getImageAssetPath()
              : getNetworkQuestions()[0].getImageAssetPath(),
        )
            :Image.asset("assets/correct.png"),

      ),
    );
  }
}
