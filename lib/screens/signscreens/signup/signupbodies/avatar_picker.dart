import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import '../../../../data/firebase/storage_services/avatars_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/strings.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key}) : super(key: key);

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _openAvatarSheet();
      },
      child: Column(
        children: [
          UserHelper.selectedAvatar == null ? Container(
            width: SizeConfig.defaultSize! * 12,
            height: SizeConfig.defaultSize! * 12,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Strings.noImage
                    )
                )
            ),
          ) :
          GetBuilder<AvatarsController>(
            builder: (avatarsStorage){
              return SizedBox(
                width: SizeConfig.defaultSize! * 12,
                height: SizeConfig.defaultSize! * 12,
                child: SvgPicture.network(
                  avatarsStorage.avatarList[UserHelper.selectedAvatar!],
                ),
              );
            },
          ),
          SizedBox(height: SizeConfig.defaultSize!,),
          Text(
            "select your avatar",
            style: TextStyle(
              color: AppColors.black.withOpacity(.5),
            ),
          )
        ],
      ),
    );
  }

  _openAvatarSheet(){
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.black.withOpacity(0.7),
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, setState){
            return Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.2, right: SizeConfig.defaultSize! * 1.2, top: SizeConfig.defaultSize! * 1.2),
              child: Container(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.2, right: SizeConfig.defaultSize! * 1.2),
                height: SizeConfig.screenHeight! / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(SizeConfig.defaultSize! * 2), topRight: Radius.circular(SizeConfig.defaultSize! * 2)),
                  color: AppColors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeConfig.defaultSize! * 2,
                        color: Colors.transparent,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!),
                        margin: EdgeInsets.only(bottom: SizeConfig.defaultSize!),
                        width: SizeConfig.defaultSize! * 20,
                        height: SizeConfig.defaultSize! * 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeConfig.screenHeight!),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(.25),
                              offset: const Offset(0, 0),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  UserHelper.selectedGender = "male";
                                });
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Strings.maleLogo,
                                    semanticsLabel: "Male Logo",
                                    width: SizeConfig.defaultSize! * 2,
                                    height: SizeConfig.defaultSize! * 2,
                                  ),
                                  SizedBox(width: SizeConfig.defaultSize,),
                                  Text(
                                    "male",
                                    style: TextStyle(
                                      color: UserHelper.selectedGender == "male" ? AppColors.green : AppColors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: SizeConfig.defaultSize! * 2.5,
                              color: AppColors.black,
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  UserHelper.selectedGender = "female";
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "female",
                                    style: TextStyle(
                                      color: UserHelper.selectedGender == "female" ? AppColors.green : AppColors.black,
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.defaultSize,),
                                  SvgPicture.asset(
                                    Strings.femaleLogo,
                                    semanticsLabel: "Female Logo",
                                    width: SizeConfig.defaultSize! * 2,
                                    height: SizeConfig.defaultSize! * 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "select your gender",
                        style: TextStyle(
                          color: AppColors.black.withOpacity(.5),
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize! * 1.5,),
                      const Divider(
                        height: 1,
                      ),
                      SizedBox(height: SizeConfig.defaultSize! * 1.5,),
                      Text(
                        "select your avatar",
                        style: TextStyle(
                          color: AppColors.black.withOpacity(.5)
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize! * 2,),
                      GetBuilder<AvatarsController>(
                        builder: (avatarsStorage){
                          return avatarsStorage.isLoaded ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: avatarsStorage.avatarList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10
                            ),
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    UserHelper.selectedAvatar = index;
                                    _mainState();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(SizeConfig.screenHeight!),
                                    border: Border.all(color: UserHelper.selectedAvatar == index ? AppColors.green.withOpacity(.7) : AppColors.black.withOpacity(.7), width: SizeConfig.defaultSize! * 0.2),
                                  ),
                                  padding: EdgeInsets.all(SizeConfig.defaultSize! * 0.1),
                                  child: SvgPicture.network(
                                    avatarsStorage.avatarList[index],
                                  ),
                                ),
                              );
                            },
                          ) : const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }

  _mainState(){
    setState(() {

    });
  }
}
