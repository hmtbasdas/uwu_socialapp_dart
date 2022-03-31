import 'package:flutter/material.dart';
import 'package:uwusocialapp/helper/user_helper.dart';

import '../../../../utils/colors.dart';

class ConfirmPasswordPicker extends StatefulWidget {
  const ConfirmPasswordPicker({Key? key}) : super(key: key);

  @override
  _ConfirmPasswordPickerState createState() => _ConfirmPasswordPickerState();
}

class _ConfirmPasswordPickerState extends State<ConfirmPasswordPicker> {

  bool? obscureConfirmPassword;

  String errorConfirmPassword = "";

  @override
  void initState() {
    obscureConfirmPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureConfirmPassword!,
      controller: UserHelper.confirmPasswordController,
      validator: (s) {
        if (s!.length < 6) {
          errorConfirmPassword = "min 6 letter";
          return errorConfirmPassword;
        }
        else if(UserHelper.passwordController.text != UserHelper.confirmPasswordController.text){
          errorConfirmPassword = "passwords are not same";
          return errorConfirmPassword;
        }
        else {
          errorConfirmPassword = "";
          return null;
        }
      },
      maxLength: 30,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Confirm Password",
        helperText: errorConfirmPassword,
        hintText: "Enter your password again",
        suffixIcon: IconButton(
          onPressed: () {
            obscureConfirmPassword = !obscureConfirmPassword!;
            setState(() {

            });
          },
          icon: Icon(
            obscureConfirmPassword!
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: AppColors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
