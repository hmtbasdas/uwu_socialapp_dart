import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import 'package:uwusocialapp/routes/route_helper.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/signupstep1body.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class SignUpStep1Screen extends StatefulWidget {
  const SignUpStep1Screen({Key? key}) : super(key: key);

  @override
  _SignUpStep1ScreenState createState() => _SignUpStep1ScreenState();
}

class _SignUpStep1ScreenState extends State<SignUpStep1Screen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: (){
        return _alertDialog();
      },
      child: Scaffold(
        appBar: step1SignUpAppBar(),
        body: const SignUpStep1Body(),
      ),
    );
  }

  AppBar step1SignUpAppBar(){
    return AppBar(
      leading: IconButton(
        onPressed: (){
          _alertDialog();
        },
        icon: Icon(
          Icons.close_rounded,
          color: AppColors.black,
          size: SizeConfig.defaultSize! * 3.5,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: (){
            String message = _controlUser();
            if(message == "ok"){
              RouteHelper.goSignUpStep2();
            }
            else {
              Get.snackbar(
                  "Warning",
                  message,
                  margin: EdgeInsets.only(top: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!),
                  backgroundColor: AppColors.red.withOpacity(.25),
                  colorText: AppColors.white
              );
            }
          },
          child: Center(
            child: Text(
              "Next",
              style: TextStyle(
                  color: AppColors.black.withOpacity(.5),
                  fontSize: SizeConfig.defaultSize! * 2
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.defaultSize! * 2,)
      ],
    );
  }

  String _controlUser(){
    if(UserHelper.nickController.text.isEmpty){
      return "nick";
    }
    else if(UserHelper.selectedDate == null){
      return "date";
    }
    else if(UserHelper.selectedCountry == null){
      return "country";
    }
    else if(UserHelper.selectedAvatar == null){
      return "avatar";
    }
    else if(UserHelper.selectedGender == null){
      return "gender";
    }
    else {
      return "ok";
    }
  }

  _alertDialog(){
    if(UserHelper.checkAllData()){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text(
                "Are you sure ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize! * 2
                ),
              ),
              content: Text(
                "All the data you entered will be lost!",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize! * 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        UserHelper.deleteAllData();
                        Navigator.pop(context);
                        Get.back();
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
      );
    }
    else {
      Get.back();
    }
  }
}

