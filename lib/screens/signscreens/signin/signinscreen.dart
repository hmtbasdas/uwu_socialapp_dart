import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/screens/signscreens/signin/signinbodies/signinbody.dart';
import 'package:uwusocialapp/utils/colors.dart';
import 'package:uwusocialapp/utils/strings.dart';

import '../../../utils/size_config.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: signInAppBar(),
      body: const SignInBody(),
    );
  }

  AppBar signInAppBar(){
    return AppBar(
      leading: IconButton(
        onPressed: (){
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
      title: Text(
        Strings.signInText,
        style: TextStyle(
            color: AppColors.black.withOpacity(.5),
            fontSize: SizeConfig.defaultSize! * 2
        ),
      ),
    );
  }
}
