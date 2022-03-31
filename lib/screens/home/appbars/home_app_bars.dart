import 'package:flutter/material.dart';
import 'package:uwusocialapp/utils/colors.dart';

class HomeAppBars {

  static AppBar matchesScreenAppBar(){
    return AppBar(
      title: Text(
        "Matches",
        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      actions: [
        Center(
          child: IconButton(
            onPressed: (){
            },
            icon: Icon(Icons.filter_list_rounded, color: AppColors.black,),
          ),
        ),
      ],
    );
  }

  static AppBar messagesScreenAppBar(){
    return AppBar(
      title: Text(
        "Messages",
        style: TextStyle(
          color: AppColors.black,
        ),
      ),
      elevation: 0,
    );
  }
}