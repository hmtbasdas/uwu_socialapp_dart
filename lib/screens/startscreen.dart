import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/firebase/auth_services/auth_service.dart';
import 'package:uwusocialapp/utils/colors.dart';
import 'package:uwusocialapp/utils/size_config.dart';
import 'package:uwusocialapp/utils/strings.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _delayed();
    return Scaffold(
      body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blue,
                    AppColors.white,
                  ]
              )
          ),
          child: Text(
            Strings.appName.toUpperCase(),
            style: TextStyle(
                fontFamily: Strings.startFontFamily,
                fontSize: SizeConfig.defaultSize! * 8,
                color: AppColors.white
            ),
          )
      ),
    );
  }

  _delayed() async {
    await Future.delayed(const Duration(seconds: 3)).whenComplete((){
      Get.find<AuthService>().currentUser();
    });
  }
}



