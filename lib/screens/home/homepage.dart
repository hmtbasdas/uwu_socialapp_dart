import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/screens/home/screens/matches_screen.dart';
import 'package:uwusocialapp/screens/home/screens/profile_screen.dart';
import 'package:uwusocialapp/screens/home/screens/messages_screen.dart';
import 'package:uwusocialapp/utils/colors.dart';

import '../../data/firebase/database_services/firestore_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List pages = const [
    MessagesScreen(),
    MatchesScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 1;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    Get.lazyPut(() => FirestoreService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.blue.withOpacity(.25),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_outlined), label: "Matches"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: "Profile"),
        ],
      ),
    );
  }
}