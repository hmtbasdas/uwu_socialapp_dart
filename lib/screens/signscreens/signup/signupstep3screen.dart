import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import 'package:uwusocialapp/routes/route_helper.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class SignUpStep3Screen extends StatelessWidget {
  const SignUpStep3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: step3SignUpAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5, top: SizeConfig.defaultSize! * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Who are you ?",
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: SizeConfig.defaultSize! * 3
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2,),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: UserHelper.bioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "write something",
              ),
              maxLines: 10,
              maxLength: 200,
            ),
          ],
        ),
      ),
    );
  }

  AppBar step3SignUpAppBar(){
    return AppBar(
      leading: IconButton(
        onPressed: (){
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.black,
          size: SizeConfig.defaultSize! * 3.5,
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: (){
              String message = _controlUSer();
              if(message == "ok"){
                RouteHelper.goSignUpStep4();
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

  String _controlUSer(){
    if(UserHelper.bioController.text.isEmpty){
      return "bio empty";
    }
    else {
      return "ok";
    }
  }
}
