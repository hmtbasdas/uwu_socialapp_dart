import 'package:get/get.dart';
import 'package:uwusocialapp/screens/home/homepage.dart';
import 'package:uwusocialapp/screens/signscreens/signin/signinscreen.dart';
import 'package:uwusocialapp/screens/signscreens/signinsignupscreen.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupstep1screen.dart';
import 'package:uwusocialapp/screens/startscreen.dart';
import '../screens/signscreens/signup/signupstep2screen.dart';
import '../screens/signscreens/signup/signupstep3screen.dart';
import '../screens/signscreens/signup/signupstep4screen.dart';

class RouteHelper {

  static const _start = StartScreen();
  static const _signInSignUp = SignInSignUpScreen();

  static const _signIn = SignInScreen();

  static const _signUpStep1 = SignUpStep1Screen();
  static const _signUpStep2 = SignUpStep2Screen();
  static const _signUpStep3 = SignUpStep3Screen();
  static const _signUpStep4 = SignUpStep4Screen();

  static const _homepage = HomePage();

  /* ---------------------------------------------------------------------------- */

  static goStart(){
    Get.offAll(_start, transition: Transition.fadeIn);
  }

  static goSignInSignUp(){
    Get.off(_signInSignUp, transition: Transition.fadeIn);
  }

  static goSignIn(){
    Get.to(_signIn, transition: Transition.fadeIn);
  }

  static goSignUpStep1(){
    Get.to(_signUpStep1, transition: Transition.fadeIn);
  }

  static goSignUpStep2(){
    Get.to(_signUpStep2, transition: Transition.rightToLeft);
  }

  static goSignUpStep3(){
    Get.to(_signUpStep3, transition: Transition.rightToLeft);
  }

  static goSignUpStep4(){
    Get.to(_signUpStep4, transition: Transition.rightToLeft);
  }

  static goHomepage(){
    Get.offAll(_homepage, transition: Transition.fadeIn);
  }
}
