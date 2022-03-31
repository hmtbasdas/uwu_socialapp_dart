import 'package:flutter/material.dart';

class UserHelper {

  static final nickController = TextEditingController();
  static DateTime? selectedDate;
  static String? selectedCountry;
  static int? selectedAvatar;
  static String? selectedGender;

  static List<String> selectedTopics = [];

  static final bioController = TextEditingController();

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final confirmPasswordController = TextEditingController();


  static deleteAllData(){
    nickController.clear();
    selectedDate = null;
    selectedCountry = null;
    selectedAvatar = null;
    selectedGender = null;
    selectedTopics.clear();
    bioController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  static bool checkAllData(){
    if(nickController.text.isNotEmpty || selectedDate != null || selectedCountry != null || selectedAvatar != null || selectedGender != null || selectedTopics.isNotEmpty || bioController.text.isNotEmpty || emailController.text.isNotEmpty || passwordController.text.isNotEmpty || confirmPasswordController.text.isNotEmpty){
      return true;
    }
    else {
      return false;
    }
  }
}