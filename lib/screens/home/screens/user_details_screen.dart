import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uwusocialapp/data/firebase/database_services/firestore_services.dart';
import '../../../models/app_user.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class UserDetailsScreen extends StatelessWidget {

  final AppUser appUser;

  const UserDetailsScreen({required this.appUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appUser.nickname,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5, top: SizeConfig.defaultSize! * .75),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: appUser.id,
                child: SvgPicture.network(
                  appUser.avatar,
                  width: SizeConfig.defaultSize! * 10,
                  height: SizeConfig.defaultSize! * 10,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize!,),

            SvgPicture.network(
              "https://countryflagsapi.com/svg/${appUser.country.toLowerCase().replaceAll(' ', '%20')}",
              height: SizeConfig.defaultSize! * 2,
              width: SizeConfig.defaultSize! * 2,
            ),
            SizedBox(height: SizeConfig.defaultSize!,),
            Text(
              appUser.country.toString(),
              style: TextStyle(
                  color: AppColors.black.withOpacity(.5),
                  fontSize: SizeConfig.defaultSize! * 1.2
              ),
            ),

            Divider(
              height: SizeConfig.defaultSize! * 3,
            ),

            Text(
              "About",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize! * 1.2,
                color: AppColors.black.withOpacity(.5),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2,),

            Row(
              children: [
                Icon(
                  Icons.date_range_rounded,
                  color: AppColors.blue.withOpacity(.5),
                  size: SizeConfig.defaultSize! * 2,
                ),
                SizedBox(width: SizeConfig.defaultSize!,),
                Text(
                  DateFormat("MMMM y").format(appUser.birthday.toDate()),
                  style: TextStyle(
                    color: AppColors.black.withOpacity(.75),
                    fontSize: SizeConfig.defaultSize! * 1.5,
                  ),
                )
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize!,),

            Row(
              children: [
                Icon(
                  Icons.person_pin_outlined,
                  color: AppColors.blue.withOpacity(.5),
                  size: SizeConfig.defaultSize! * 2,
                ),
                SizedBox(width: SizeConfig.defaultSize!,),
                Text(
                  appUser.gender[0].toUpperCase() + appUser.gender.substring(1).toString(),
                  style: TextStyle(
                    color: AppColors.black.withOpacity(.75),
                    fontSize: SizeConfig.defaultSize! * 1.5,
                  ),
                )
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize!,),

            Divider(
              height: SizeConfig.defaultSize! * 3,
            ),

            Text(
              "Bio",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize! * 1.2,
                color: AppColors.black.withOpacity(.5),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2,),

            Text(
              appUser.bio,
              style: TextStyle(
                color: AppColors.black.withOpacity(.75),
                fontSize: SizeConfig.defaultSize! * 1.5
              ),
            ),

            Divider(
              height: SizeConfig.defaultSize! * 3,
            ),

            Text(
              "Common Topics",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize! * 1.5,
                color: AppColors.black.withOpacity(.5),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2,),

            /*Expanded(
              child: GetBuilder<FirestoreService>(
                builder: (firestoreService){
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3/2,
                    ),
                    itemBuilder: (context, index){
                      return Container(
                        child: Text(
                            firestoreService.listUsers[index].topics.toString()
                        ),
                      );
                    },
                  );
                },
              ),
            )*/
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 8/2
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(.75),
                    borderRadius: BorderRadius.circular(SizeConfig.defaultSize!),
                  ),
                  child: Center(
                    child: Text(
                      appUser.topics[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: SizeConfig.defaultSize! * 1.5
                      ),
                    ),
                  )
                );
              },
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2,),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(SizeConfig.defaultSize!),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(.25),
                    offset: const Offset(0, 0),
                    blurRadius: 20,
                  )
                ]
              ),
              child: TextButton(
                onPressed: (){

                },
                child: Center(
                  child: Text(
                    "Add Friend +",
                    style: TextStyle(
                        color: AppColors.black.withOpacity(.5)
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2,),
          ],
        ),
      ),
    );
  }
}
