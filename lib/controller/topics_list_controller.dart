import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/repository/topics_repo.dart';
import 'package:uwusocialapp/models/topics.dart';

class TopicsListController extends GetxController {

  final TopicsRepository topicsRepository;

  TopicsListController({required this.topicsRepository});

  List<dynamic> _topicList = [];
  List<dynamic> get topicList => _topicList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future<void> getTopicsList() async {
    Response response = await topicsRepository.getTopicsList();

    if(response.statusCode == 200){
      debugPrint("basari topics");
      List<dynamic> list = json.decode(response.body);
      _topicList = list.map((e) => Topics.fromJson(e).name).toList();

      if(_isLoaded == false){
        _isLoaded = true;
        update();
      }

    }
    else {
      debugPrint(response.statusText);
    }
  }
}