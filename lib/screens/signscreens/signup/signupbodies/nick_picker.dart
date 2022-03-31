import 'package:flutter/material.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import '../../../../utils/colors.dart';

class NickPicker extends StatelessWidget {
  const NickPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: UserHelper.nickController,
      maxLength: 20,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Nickname",
        hintText: "Enter your nickname",
        suffixIcon: Icon(
          Icons.person_outline_rounded,
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
