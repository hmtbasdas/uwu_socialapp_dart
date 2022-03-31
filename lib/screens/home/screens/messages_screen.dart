import 'package:flutter/material.dart';
import 'package:uwusocialapp/utils/colors.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Messages Screen but still empty :/",
        style: TextStyle(
          color: AppColors.black.withOpacity(.5)
        ),
      ),
    );
  }
}
