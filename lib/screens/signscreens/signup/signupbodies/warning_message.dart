import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/size_config.dart';

class WarningMessage extends StatelessWidget {
  const WarningMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: AppColors.red,
          size: SizeConfig.defaultSize! * 1.6,
        ),
        SizedBox(width: SizeConfig.defaultSize! * 0.5,),
        Expanded(
          child: Text(
            "Be careful! These informations will not be changed again.",
            style: TextStyle(
                color: AppColors.red,
                fontSize: SizeConfig.defaultSize! * 1.2,
                fontWeight: FontWeight.w500
            ),
          ),
        )
      ],
    );
  }
}
