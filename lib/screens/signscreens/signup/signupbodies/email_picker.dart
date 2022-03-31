import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/helper/user_helper.dart';

import '../../../../utils/colors.dart';

class EmailPicker extends StatefulWidget {
  const EmailPicker({Key? key}) : super(key: key);

  @override
  _EmailPickerState createState() => _EmailPickerState();
}

class _EmailPickerState extends State<EmailPicker> {

  String errorEmailMessage = "";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: UserHelper.emailController,
      validator: (s) {
        if (!s!.isEmail) {
          errorEmailMessage = "Email is not verified, please check it";
          return errorEmailMessage;
        }
        else if (s.isEmpty) {
          errorEmailMessage = "Email is can't be empty";
          return errorEmailMessage;
        }
        else {
          errorEmailMessage = "";
          return null;
        }
      },
      maxLength: 30,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Email",
        helperText: errorEmailMessage,
        hintText: "Enter your email",
        suffixIcon: Icon(
          Icons.mail_outline_rounded,
          color: AppColors.black.withOpacity(.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(.5),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
