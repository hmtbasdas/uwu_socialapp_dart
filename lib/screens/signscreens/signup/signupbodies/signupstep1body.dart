import 'package:flutter/material.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/avatar_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/birthday_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/country_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/nick_picker.dart';
import 'package:uwusocialapp/screens/signscreens/signup/signupbodies/warning_message.dart';
import 'package:uwusocialapp/utils/size_config.dart';

class SignUpStep1Body extends StatelessWidget {
  const SignUpStep1Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<String> items = ["British Indian Ocean Territory","The Democratic Republic of Congo","Heard Island and McDonald Islands","Saint Vincent and the Grenadines", "South Georgia and the South Sandwich Islands","United States Minor Outlying Islands"];
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 2.4, right: SizeConfig.defaultSize! * 2.4, top: SizeConfig.defaultSize! * 2.4,),
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AvatarPicker(),
            SizedBox(height: SizeConfig.defaultSize! * 5,),
            const WarningMessage(),
            SizedBox(height: SizeConfig.defaultSize! * 2,),
            const NickPicker(),
            SizedBox(height: SizeConfig.defaultSize!,),
            const BirthdayPicker(),
            SizedBox(height: SizeConfig.defaultSize!,),
            const CountryPicker(),
          ],
        ),
      ),
    );
  }
}
