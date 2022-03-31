import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import '../../../../utils/colors.dart';

class BirthdayPicker extends StatefulWidget {
  const BirthdayPicker({Key? key}) : super(key: key);

  @override
  _BirthdayPickerState createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(DateTime.now().year - 16),
          lastDate: DateTime(DateTime.now().year - 16),
          firstDate: DateTime(1900),
        );

        if(picked != null && picked != UserHelper.selectedDate){
          setState(() {
            UserHelper.selectedDate = picked;
          });
        }
      },
      child: TextFormField(
        enabled: false,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: UserHelper.selectedDate == null ? "Birthday" : DateFormat("EEEE, MM, yyyy").format(UserHelper.selectedDate!),
          labelStyle: TextStyle(
            color: UserHelper.selectedDate == null ? AppColors.black.withOpacity(.5) : AppColors.black
          ),
          helperText: "",
          hintText: "",
          suffixIcon: Icon(
            Icons.calendar_today_rounded,
            color: AppColors.black.withOpacity(.5),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.black.withOpacity(.5)
              )
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
      ),
    );
  }
}
