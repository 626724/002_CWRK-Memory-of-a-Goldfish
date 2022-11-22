import 'dart:convert';
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

List<NetworkTileModel> networkPairs = [];

List<NetworkTileModel> networkImages = <NetworkTileModel>[];
List<TileModel> networkImagess = <TileModel>[];
var response;
var decodedJson;
List picture_set = [];
List<String> image_urls = [];
Future<List<String>> getData()  async {
  String url = "https://goparker.com/600096/memory/goldfish/index.json";
  String hostUrl = "https://goparker.com/600096/memory/goldfish/";
  var dio = Dio();
  response = await dio.get(url);
  if(response.statusCode==200){
    decodedJson = jsonDecode(response.toString());
    picture_set = decodedJson["PictureSet"];
    print("THis is the length of picture set ${picture_set.length}");


    for (int i = 0; i <= picture_set.length; i++) {

      String image_url = hostUrl + picture_set[i];
      print(image_url);
      image_urls.add(image_url);
      // print(image_urls);

    }
    print(
        "THESE ARE THE IMAGE URLS  ---------------------------- $image_urls");}

  return image_urls;
}


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

  tileModel = TileModel(imageAssetPath: "assets/zoo.png", isSelected: false);
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

// List<NetworkTileModel> getNetworkPairs() {
//   List<NetworkTileModel> networkPairs = <NetworkTileModel>[];
//   NetworkTileModel tileModel =
//       NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish1.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish2.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish3.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish4.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish5.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish6.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish7.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish8.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish9.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish10.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish11.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish12.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish13.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish14.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish15.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish16.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish17.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish18.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish19.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//
//   tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/goldfish20.png", isSelected: false);
//   networkPairs.add(tileModel);
//   networkPairs.add(tileModel);
//   return networkPairs;
// }

List<NetworkTileModel> getNetworkPairs() {
  // getData();
  List<NetworkTileModel> networkPairs = <NetworkTileModel>[];
    print("This is the list of image urls ============================================================================= ${image_urls}");
    // NetworkTileModel tileModel =
    // NetworkTileModel(imageURL: "https://www.goparker.com/600096/memory/goldfish/images/goldfish1.png", isSelected: false);
    for (int i = 1; i<=20;i++){
    NetworkTileModel  tileModel = NetworkTileModel(imageURL: image_urls[i], isSelected: false);
      networkPairs.add(tileModel);
      networkPairs.add(tileModel);
      print("This is the image url ${image_urls[i]}");
    }
    print(image_urls);
  return networkPairs;
}
List<NetworkTileModel> getNetworkQuestions() {
  List<NetworkTileModel> networkPairs = <NetworkTileModel>[];
  NetworkTileModel tileModel =
  NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  tileModel = NetworkTileModel(imageURL: "https://goparker.com/600096/memory/goldfish/images/tileback_g.png", isSelected: false);
  networkPairs.add(tileModel);
  networkPairs.add(tileModel);

  return networkPairs;
}
