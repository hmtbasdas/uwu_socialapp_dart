import 'package:flutter/material.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import '../../../../utils/colors.dart';

class PasswordPicker extends StatefulWidget {
  const PasswordPicker({Key? key}) : super(key: key);

  @override
  _PasswordPickerState createState() => _PasswordPickerState();
}

class _PasswordPickerState extends State<PasswordPicker> {

  bool? obscurePassword;

  String errorPassword = "";

  @override
  void initState() {
    obscurePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscurePassword!,
      controller: UserHelper.passwordController,
      validator: (s) {
        if (s!.length < 6) {
          errorPassword = "min 6 letter";
          return errorPassword;
        }
        else {
          errorPassword = "";
          return null;
        }
      },
      maxLength: 30,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Password",
        helperText: errorPassword,
        hintText: "Enter your password",
        suffixIcon: IconButton(
          onPressed: () {
            obscurePassword = !obscurePassword!;
            setState(() {});
          },
          icon: Icon(
            obscurePassword!
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: AppColors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
