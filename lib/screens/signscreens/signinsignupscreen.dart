import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/routes/route_helper.dart';
import 'package:uwusocialapp/utils/strings.dart';
import '../../controller/country_list_controller.dart';
import '../../controller/topics_list_controller.dart';
import '../../data/firebase/storage_services/avatars_controller.dart';
import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import 'package:uwusocialapp/helper/dependencies.dart' as dep;

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({Key? key}) : super(key: key);

  @override
  _SignInSignUpScreenState createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {

  @override
  void initState() {
    _dep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 2.4, right: SizeConfig.defaultSize! * 2.4, top: SizeConfig.defaultSize! * 2.4, bottom: SizeConfig.defaultSize! * 2.4),
          height: SizeConfig.screenHeight,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: SizeConfig.defaultSize! * 12,
                  height: SizeConfig.defaultSize! * 12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            Strings.appLogo,
                          )
                      )
                  ),
                ),
                Text(
                  Strings.appName.toUpperCase(),
                  style: TextStyle(
                      fontFamily: Strings.startFontFamily,
                      fontSize: SizeConfig.defaultSize! * 7,
                      color: AppColors.secondBlue,
                      letterSpacing: 5
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! * 1.2),
                Text(
                  Strings.signInSignUpScreenText,
                  style: TextStyle(
                      fontSize: SizeConfig.defaultSize! * 1.3,
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.defaultSize! * 8),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4
                            ),
                          ]
                      ),
                      child: TextButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(SizeConfig.screenWidth!, SizeConfig.defaultSize! * 6),
                            backgroundColor: AppColors.blue
                        ),
                        onPressed: (){
                          RouteHelper.goSignUpStep1();
                        },
                        child: Text(
                          Strings.noAccountText,
                          style: TextStyle(
                              color: AppColors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize! * 2,),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4
                            ),
                          ]
                      ),
                      child: TextButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(SizeConfig.screenWidth!, SizeConfig.defaultSize! * 6),
                            backgroundColor: AppColors.white
                        ),
                        onPressed: (){
                          RouteHelper.goSignIn();
                        },
                        child: Text(
                          Strings.haveAccountText,
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.black,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  _dep() async {
    await dep.init().whenComplete((){
      Get.find<AvatarsController>().getAvatars();
      Get.find<CountryListController>().getCountryList();
      Get.find<TopicsListController>().getTopicsList();
    });
  }
}

