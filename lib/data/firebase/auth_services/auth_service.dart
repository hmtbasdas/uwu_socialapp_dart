import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/firebase/abstracts/auth_base.dart';
import 'package:uwusocialapp/data/firebase/database_services/firestore_services.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import 'package:uwusocialapp/routes/route_helper.dart';
import 'package:uwusocialapp/screens/signscreens/signin/signinscreen.dart';
import 'package:uwusocialapp/utils/size_config.dart';
import '../../../utils/colors.dart';

class AuthService extends GetxController implements AuthBase {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  bool _isSignInLoading = false;
  bool get isSignInLoading => _isSignInLoading;

  bool _isSignUpLoading = false;
  bool get isSignUpLoading => _isSignUpLoading;

  @override
  Future<void> currentUser() async {
    _user();

    if(user == null){
      RouteHelper.goSignInSignUp();
    }
    else {
      if(await checkEmailVerification()){
        _isSignInLoading = false;
        update();

        RouteHelper.goHomepage();
      }
      else{
        _isSignInLoading = false;
        update();

        Get.snackbar(
          "Information",
          "account is not verify, please check your mailbox",
          backgroundColor: AppColors.yellow.withOpacity(0.3),
          margin: EdgeInsets.only(top: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!),
          colorText: AppColors.white,
        );
        sendEmailVerification();
        signOut();
      }
    }
  }

  @override
  Future<bool> forgotPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    }
    catch(error){
      return false;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try{
      _isSignInLoading = true;
      update();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      currentUser();
    }
    catch(error){
      _isSignInLoading = false;
      update();

      debugPrint(error.toString());

      Get.snackbar(
        "Error",
        "user information is incorrect, please try again",
        backgroundColor: AppColors.red.withOpacity(0.3),
        margin: EdgeInsets.only(top: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!),
        colorText: AppColors.white,
      );
    }
  }

  @override
  Future<bool> sendEmailVerification() async {
    _user();
    try{
      await user!.sendEmailVerification();
      return true;
    }
    catch(error){
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      await _auth.signOut();
      return true;
    }
    catch(error){
      debugPrint(error.toString());
      return false;
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try{
      _isSignUpLoading = true;
      update();

      await _auth.createUserWithEmailAndPassword(email: email, password: password).whenComplete((){
        Get.find<FirestoreService>().addUserData().whenComplete((){
          signOut();

          _isSignUpLoading = false;
          update();

          UserHelper.deleteAllData();
          Get.offAll(const SignInScreen());
        });
      });

      Get.snackbar(
        "Success",
        "account created successfully",
        backgroundColor: AppColors.green.withOpacity(0.3),
        margin: EdgeInsets.only(top: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!),
        colorText: AppColors.white,
      );
    }
    catch(error){
      _isSignUpLoading = false;
      update();

      Get.snackbar(
        "Error",
        "something went wrong, please try again",
        backgroundColor: AppColors.red.withOpacity(0.3),
        margin: EdgeInsets.only(top: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!),
        colorText: AppColors.white,
      );
    }
  }

  @override
  Future<bool> checkEmailVerification() async {
    _user();
    if(user!.emailVerified){
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<bool> isLoggedUser() async {
    _user();
    debugPrint(user.toString());
    if(user != null){
      return true;
    }
    else {
      return false;
    }
  }

  String getUserId(){
    _user();
    return user!.uid;
  }

  _user() async {
    user = _auth.currentUser;
  }
}