import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/data/firebase/auth_services/auth_service.dart';
import 'package:uwusocialapp/data/firebase/database_services/firestore_services.dart';
import 'package:uwusocialapp/utils/size_config.dart';
import '../../../utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    TabController _tabController  = TabController(length: 2, vsync: this);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Name",
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          GetBuilder<AuthService>(
            builder: (authService){
              return IconButton(
                icon: Icon(
                  Icons.logout,
                  color: AppColors.black,
                  size: SizeConfig.defaultSize! * 2.5,
                ),
                onPressed: () async {
                  if(await authService.signOut()){
                    authService.currentUser();
                  }
                },
              );
            },
          )
        ],
      ),
      body: GetBuilder<FirestoreService>(
        builder: (firestoreService){
          return Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: SvgPicture.network(
                        firestoreService.currentUserValues.avatar,
                        width: SizeConfig.defaultSize! * 10,
                        height: SizeConfig.defaultSize! * 10,
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.defaultSize! * 7,
                      bottom: SizeConfig.defaultSize! * 7,
                      child: Container(
                        height: SizeConfig.defaultSize! * 3.5,
                        width: SizeConfig.defaultSize! * 3.5,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(SizeConfig.screenHeight!),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(.25),
                                offset: const Offset(0, 0),
                                blurRadius: 10,
                              ),
                            ]
                        ),
                        child: Icon(
                          Icons.edit,
                          color: AppColors.blue.withOpacity(.5),
                          size: SizeConfig.defaultSize! * 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: SizeConfig.defaultSize! * 5, indent: SizeConfig.defaultSize! * 1.5, endIndent: SizeConfig.defaultSize! * 1.5,),

              TabBar(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5),
                controller: _tabController,
                unselectedLabelColor: AppColors.blue.withOpacity(.5),
                labelColor: AppColors.blue,
                indicatorColor: AppColors.blue,
                tabs: [
                  Tab(
                    text: "Friends (5)",
                  ),
                  Tab(
                    text: "Requests (2)",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _friendsList(),
                    _requestsList()
                  ],
                ),
              )
            ],
          );
        },
      )
    );
  }

  Widget _friendsList(){
    return ListView.builder(
      padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5, top: SizeConfig.defaultSize! * 2),
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(bottom: SizeConfig.defaultSize! * 2),
          padding: EdgeInsets.all(SizeConfig.defaultSize!),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize!),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(.25),
                offset: const Offset(0, 0),
                blurRadius: 10
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/avatar_1.svg",
                    width: SizeConfig.defaultSize! * 5,
                    height: SizeConfig.defaultSize! * 5,
                  ),
                  SizedBox(width: SizeConfig.defaultSize!,),
                  Text(
                    "nickname",
                    style: TextStyle(
                      color: AppColors.black.withOpacity(.75),
                      fontSize: SizeConfig.defaultSize! * 1.75,
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.send_rounded,
                  color: AppColors.blue.withOpacity(.75),
                  size: SizeConfig.defaultSize! * 2.75,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _requestsList(){
    return ListView.builder(
      padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5, top: SizeConfig.defaultSize! * 2),
      physics: const BouncingScrollPhysics(),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(bottom: SizeConfig.defaultSize! * 2),
          padding: EdgeInsets.all(SizeConfig.defaultSize!),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(SizeConfig.defaultSize!),
              boxShadow: [
                BoxShadow(
                    color: AppColors.black.withOpacity(.25),
                    offset: const Offset(0, 0),
                    blurRadius: 10
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/avatar_2.svg",
                    width: SizeConfig.defaultSize! * 5,
                    height: SizeConfig.defaultSize! * 5,
                  ),
                  SizedBox(width: SizeConfig.defaultSize!,),
                  Text(
                    "nickname",
                    style: TextStyle(
                      color: AppColors.black.withOpacity(.75),
                      fontSize: SizeConfig.defaultSize! * 1.75,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.mood_rounded,
                      color: AppColors.green.withOpacity(.75),
                      size: SizeConfig.defaultSize! * 3,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.mood_bad_rounded,
                      color: AppColors.red.withOpacity(.75),
                      size: SizeConfig.defaultSize! * 3,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

