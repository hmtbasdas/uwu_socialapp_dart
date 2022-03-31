import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/firebase/auth_services/auth_service.dart';
import 'package:uwusocialapp/screens/signscreens/signin/signinbodies/email_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signin/signinbodies/password_picker.dart';
import 'package:uwusocialapp/utils/colors.dart';
import 'package:uwusocialapp/utils/strings.dart';

import '../../../../utils/size_config.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {

  //TextEditingController? emailController;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 2.4, right: SizeConfig.defaultSize! * 2.4, top: SizeConfig.defaultSize! * 2.4, bottom: SizeConfig.defaultSize! * 2.4),
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.welcomeText,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.defaultSize! * 3
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 1.2,),
            Text(
              Strings.signInSignUpScreenText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black.withOpacity(.5),
                fontSize: SizeConfig.defaultSize! * 1.5
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 3.2,),
            Column(
              children: [
                EmailPicker(emailController: emailController,),
                SizedBox(height: SizeConfig.defaultSize!,),
                PasswordPicker(passwordController: passwordController,)
              ],
            ),
            GestureDetector(
              onTap: (){

              },
              child: Text(
                Strings.forgotPassText,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: SizeConfig.defaultSize! * 1.5,
                  letterSpacing: 1
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 3.2,),
            GetBuilder<AuthService>(
              builder: (authService){
                return !authService.isSignInLoading ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            AppColors.blue,
                            AppColors.white,
                          ]
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: TextButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(SizeConfig.screenWidth!, SizeConfig.defaultSize! * 6),
                    ),
                    onPressed: (){
                      debugPrint(emailController.text);
                      authService.signIn(emailController.text, passwordController.text);
                    },
                    child: Text(
                      Strings.signInText,
                      style: TextStyle(
                          color: AppColors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ) : const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
