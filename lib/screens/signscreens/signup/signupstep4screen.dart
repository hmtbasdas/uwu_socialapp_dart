import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/firebase/auth_services/auth_service.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/confirmPassword_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/email_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/password_picker.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';
import '../../../utils/strings.dart';

class SignUpStep4Screen extends StatefulWidget {
  const SignUpStep4Screen({Key? key}) : super(key: key);

  @override
  _SignUpStep4ScreenState createState() => _SignUpStep4ScreenState();
}

class _SignUpStep4ScreenState extends State<SignUpStep4Screen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: step4SignUpAppBar(),
      body: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.defaultSize! * 2.4,
            right: SizeConfig.defaultSize! * 2.4,
            top: SizeConfig.defaultSize! * 2.4,
            bottom: SizeConfig.defaultSize! * 2.4),
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Last Step",
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize! * 3),
              ),
              SizedBox(
                height: SizeConfig.defaultSize! * 1.2,
              ),
              Text(
                Strings.signInSignUpScreenText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.black.withOpacity(.5),
                    fontSize: SizeConfig.defaultSize! * 1.5),
              ),
              SizedBox(
                height: SizeConfig.defaultSize! * 3.2,
              ),
              Column(
                children: [
                  const EmailPicker(),
                  SizedBox(height: SizeConfig.defaultSize!,),
                  const PasswordPicker(),
                  SizedBox(height: SizeConfig.defaultSize!,),
                  const ConfirmPasswordPicker(),
                ],
              ),
              SizedBox(
                height: SizeConfig.defaultSize! * 3.2,
              ),
              GetBuilder<AuthService>(
                builder: (authService){
                  return !authService.isSignUpLoading ? Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppColors.blue,
                          AppColors.white,
                        ]),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(
                            SizeConfig.screenWidth!, SizeConfig.defaultSize! * 6),
                      ),
                      onPressed: () {
                        String message = _controlUser();
                        if(message == "ok"){
                          _signUp();
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
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppColors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ) : const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar step4SignUpAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.black,
          size: SizeConfig.defaultSize! * 3.5,
        ),
      ),
      title: Text(
        "Sign Up",
        style: TextStyle(
          color: AppColors.black.withOpacity(.5),
          fontSize: SizeConfig.defaultSize! * 2,
        ),
      ),
      centerTitle: true,
    );
  }

  _signUp(){
    Get.find<AuthService>().signUp(UserHelper.emailController.text, UserHelper.passwordController.text);
  }

  String _controlUser(){
    if(!UserHelper.emailController.text.isEmail){
      return "bad email format";
    }
    else if(UserHelper.emailController.text.isEmpty){
      return "email is can't be empty";
    }
    else if(UserHelper.passwordController.text != UserHelper.confirmPasswordController.text){
      return "passwords are must be same";
    }
    else {
      return "ok";
    }
  }
}
