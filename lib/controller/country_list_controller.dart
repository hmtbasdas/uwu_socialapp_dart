import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/repository/country_repo.dart';
import 'package:uwusocialapp/models/countries.dart';

class CountryListController extends GetxController {

  final CountryRepository countryRepository;

  CountryListController({required this.countryRepository});

  List<dynamic> _countryList = [];
  List<dynamic> get allCountryList => _countryList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCountryList() async {
    Response response = await countryRepository.getCountryList();

    if(response.statusCode == 200){
      debugPrint("basari");
      List<dynamic> list = json.decode(response.body);
      _countryList = list.map((e) => Countries.fromJson(e).country).toList();
      if(_isLoaded == false){
        _isLoaded = true;
        update();
      }
    }
    else{
      debugPrint(response.statusText);
    }
  }
}