import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

import '../model/tileModel.dart';

int points = 0;
bool networkSelected = false;
bool selected = false;
String selectedImageAssetPath = '';
String selectedImageURL = "";
int selectedTileIndex = 0;
List<TileModel> pairs = <TileModel>[];
List<TileModel> visiblePairs = <TileModel>[];
List<NetworkTileModel> visibleNetworkPairs = <NetworkTileModel>[];
String url = "";
String hostUrl = "";
List<NetworkTileModel> networkPairs = [];
bool fish = true;
int moves = 0;
late bool game_started;
int duration = 60*1;
int countdown = 60*1;
bool absorbing = true;
bool isVisible = false;
bool auto = false;


List<NetworkTileModel> networkImages = <NetworkTileModel>[];
List<TileModel> networkImagess = <TileModel>[];
var response;
var decodedJson;
var dio = Dio();
List picture_set = [];

//define setTileIndex


Future<List> getData() async {
  List image_urls = [];
  url = "https://goparker.com/600096/memory/goldfish/index.json";
  hostUrl = "https://goparker.com/600096/memory/goldfish/";
  dio = Dio();
  response = await dio.get(url);
  if (response.statusCode == 200) {
    decodedJson = jsonDecode(response.toString());
    picture_set = decodedJson["PictureSet"];
    print("THis is the length of picture set ${picture_set.length}");

    for (int i = 0; i <= picture_set.length - 1; i++) {
      String image_url = hostUrl + picture_set[i];
      print(image_url);
      image_urls.add(image_url);
      // print(image_urls);
    }
    print("THESE ARE THE IMAGE URLS  ---------------------------- $image_urls");
  }

  return image_urls;
}

var image_urls = [];

List<String> links = List.generate(20, (index) {
  return url =
      "https://goparker.com/600096/memory/goldfish/images/goldfish${index + 1}.png";
});

List<TileModel> getPairs() {
  List<TileModel> pairs = <TileModel>[];
  TileModel tileModel =
      TileModel(imageAssetPath: "assets/fox.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = TileModel(imageAssetPath: "assets/hippo.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = TileModel(imageAssetPath: "assets/horse.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = TileModel(imageAssetPath: "assets/monkey.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = TileModel(imageAssetPath: "assets/panda.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = TileModel(imageAssetPath: "assets/parrot.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = TileModel(imageAssetPath: "assets/rabbit.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel = TileModel(imageAssetPath: "assets/elephant.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  return pairs;
}

List<TileModel> getQuestions() {
  List<TileModel> pairs = <TileModel>[];
  TileModel tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  tileModel =
      TileModel(imageAssetPath: "assets/question.png", isSelected: false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  return pairs;
}

List<NetworkTileModel> getNetworkPairs() {
  List<NetworkTileModel> networkPairs = <NetworkTileModel>[];
  NetworkTileModel tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish1.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant1.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish2.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant2.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish3.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant3.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish4.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant4.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish5.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant5.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish7.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant7.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish8.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant8.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish9.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant9.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish10.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant10.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish11.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant11.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish12.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant12.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish13.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant13.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish14.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant14.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish15.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant15.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish16.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant16.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish17.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant17.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish18.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant18.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish19.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant19.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish20.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant20.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL: fish
          ? "https://goparker.com/600096/memory/goldfish/images/goldfish6.png"
          : "https://goparker.com/600096/memory/elephant/images/elephant6.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  return networkPairs;
}

// List<NetworkTileModel> getNetworkPairs() {
//   // getData();
//   List<NetworkTileModel> networkPairs = <NetworkTileModel>[];
//     print("This is the list of image urls ============================================================================= ${image_urls}");
//     NetworkTileModel tileModel =
//     NetworkTileModel(imageURL: "https://www.goparker.com/600096/memory/goldfish/images/goldfish1.png", isSelected: false);
//     for (int i = 1; i<=20;i++){
//     NetworkTileModel  tileModel = NetworkTileModel(imageURL: image_urls[i], isSelected: false);
//       networkPairs.add(tileModel);
//       networkPairs.add(tileModel);
//       print("This is the image url ${image_urls[i]}");
//     }
//     print(image_urls);
//   return networkPairs;
// }
List<NetworkTileModel> getNetworkQuestions() {
  List<NetworkTileModel> networkPairs = <NetworkTileModel>[];
  NetworkTileModel tileModel = NetworkTileModel(
      imageURL:
          fish?
          // "https://media.giphy.com/media/xTiTnet7xRv1GPTShi/giphy.gif"
              "https://goparker.com/600096/memory/goldfish/images/tileback_g.png"


              :"https://goparker.com/600096/memory/elephant/images/tileback_e.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(
      imageURL:
          "https://goparker.com/600096/memory/goldfish/images/tileback_g.png",
      isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  return networkPairs;
}
