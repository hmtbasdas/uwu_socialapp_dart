import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/firebase/abstracts/database.dart';
import 'package:uwusocialapp/data/firebase/auth_services/auth_service.dart';
import 'package:uwusocialapp/data/firebase/storage_services/avatars_controller.dart';
import 'package:uwusocialapp/helper/filters.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import 'package:uwusocialapp/models/app_user.dart';

class FirestoreService extends GetxController implements Database {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late AppUser _currentUserValues;
  AppUser get currentUserValues => _currentUserValues;

  late List<AppUser> _listUsers;
  List<AppUser> get listUsers => _listUsers;

  List<AppUser> _tempListUsers = [];

  bool _isLoaded = true;
  bool get isLoaded => _isLoaded;

  @override
  void onInit() {
    _getCurrentUserValues();
    super.onInit();
  }

  @override
  Future<void> addUserData() async {
    await firebaseFirestore.collection("users").doc(_getUserId()).set(userMap()); //.add(userMap());
  }

  @override
  Future<void> getUsersData() async {
    debugPrint("YENİ GET DATA");
    _listUsers = [];

    if(await _getCurrentUserValues()){
      await firebaseFirestore.collection("users").get().then((QuerySnapshot querySnapshot){
        for (var element in querySnapshot.docs) {
          if(element['id'].toString().trim() != _currentUserValues.id.trim()){
            debugPrint(element['id'].toString());
            _listUsers.add(AppUser(
              element['id'],
              element['nickname'],
              element['gender'],
              element['birthday'],
              element['country'],
              element['avatar'],
              element['bio'],
              element['topics'],
            ));
          }
        }
      }).whenComplete((){
        _filters();
      });
    }
  }

  Map<String, dynamic> userMap(){
    return {
      'id': _getUserId(),
      'nickname': UserHelper.nickController.text,
      'mail': UserHelper.emailController.text,
      'birthday': UserHelper.selectedDate,
      'country': UserHelper.selectedCountry,
      'topics': UserHelper.selectedTopics,
      'gender': UserHelper.selectedGender,
      'bio': UserHelper.bioController.text,
      'avatar': Get.find<AvatarsController>().avatarList[UserHelper.selectedAvatar!],
    };
  }

  String _getUserId(){
    return Get.find<AuthService>().getUserId();
  }

  Future<bool> _getCurrentUserValues() async {
    try{
      await firebaseFirestore.collection("users").doc(_getUserId()).get()
          .then((DocumentSnapshot element){
        if(element.exists){
          _currentUserValues = AppUser(
            element['id'],
            element['nickname'],
            element['gender'],
            element['birthday'],
            element['country'],
            element['avatar'],
            element['bio'],
            element['topics'],
          );
        }
      });
      return true;
    }
    catch(error){
      return false;
    }
  }

  _filters(){
    debugPrint("List BÖYÜKLÜĞÜ: " + _listUsers.length.toString());
    _countryFilter();
    _maleFilter();
    _femaleFilter();
    _ageValue();

    _isLoaded = false;
    update();
  }

  _countryFilter(){
    if(Filters.countryValue && _listUsers.isNotEmpty){
      for(int i=0;i<_listUsers.length;i++){
        if(_listUsers[i].country.trim() == _currentUserValues.country.trim()){
          _tempListUsers.add(_listUsers[i]);
        }
      }
      _listUsers = _tempListUsers;
      _tempListUsers = [];
    }
  }

  _maleFilter(){
    if(!Filters.maleValue && _listUsers.isNotEmpty){
      for(int i=0;i<_listUsers.length;i++){
        if(_listUsers[i].gender.trim() == "female"){
          _tempListUsers.add(_listUsers[i]);
        }
      }
      _listUsers = _tempListUsers;
      _tempListUsers = [];
    }
  }

  _femaleFilter(){
    if(!Filters.femaleValue && _listUsers.isNotEmpty){
      for(int i=0;i<_listUsers.length;i++){
        if(_listUsers[i].gender.trim() == "male"){
          _tempListUsers.add(_listUsers[i]);
        }
      }
      _listUsers = _tempListUsers;
      _tempListUsers = [];
    }
  }

  _ageValue(){
    if(Filters.ageRangeController.text.isNotEmpty && _listUsers.isNotEmpty){
      for(int i=0;i<_listUsers.length;i++){
        if((DateTime.now().year - _listUsers[i].birthday.toDate().year) < int.parse(Filters.ageRangeController.text.toString())){
          _tempListUsers.add(_listUsers[i]);
        }
      }

      _listUsers = _tempListUsers;
      _tempListUsers = [];
    }
  }

  int _matchedCounter(QueryDocumentSnapshot element){
    int counter = 0;
    for(int i=0;i<10;i++){
      for(int j=0;j<10;j++){
        if(element['topics'][i] == _currentUserValues.topics[j]){
          counter++;
        }
      }
    }
    return counter;
  }
}