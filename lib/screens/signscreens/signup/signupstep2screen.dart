import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uwusocialapp/controller/topics_list_controller.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import 'package:uwusocialapp/routes/route_helper.dart';
import 'package:uwusocialapp/utils/size_config.dart';
import '../../../utils/colors.dart';

class SignUpStep2Screen extends StatefulWidget {
  const SignUpStep2Screen({Key? key}) : super(key: key);

  @override
  _SignUpStep2ScreenState createState() => _SignUpStep2ScreenState();
}

class _SignUpStep2ScreenState extends State<SignUpStep2Screen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    debugPrint(UserHelper.selectedTopics.toString());
    return Scaffold(
      appBar: step2SignUpAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5, top: SizeConfig.defaultSize! * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What are you\ninterested in ?",
              style: TextStyle(
                color: AppColors.black,
                fontSize: SizeConfig.defaultSize! * 3
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select 10 topics",
                  style: TextStyle(
                    color: AppColors.black.withOpacity(.5),
                    fontSize: SizeConfig.defaultSize! * 1.5,
                  ),
                ),
                Container(
                  width: SizeConfig.defaultSize! * 7,
                  height: SizeConfig.defaultSize! * 2.5,
                  decoration: BoxDecoration(
                    color: UserHelper.selectedTopics.length < 10 ? AppColors.black.withOpacity(.25) : AppColors.green,
                    borderRadius: BorderRadius.circular(SizeConfig.screenHeight!),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${UserHelper.selectedTopics.length} / 10",
                    style: TextStyle(
                      color: AppColors.white
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize! * 3,),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: GetBuilder<TopicsListController>(
                  builder: (topicListController){
                    return topicListController.isLoaded ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: topicListController.topicList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 3/1
                      ),
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            if(UserHelper.selectedTopics.contains(topicListController.topicList[index]) && UserHelper.selectedTopics.length <= 10){
                              setState(() {
                                UserHelper.selectedTopics.remove(topicListController.topicList[index]);
                              });
                            }
                            else if (UserHelper.selectedTopics.length < 10){
                              setState(() {
                                UserHelper.selectedTopics.add(topicListController.topicList[index]);
                              });
                            }
                            else {
                              Get.snackbar(
                                "Max Topics",
                                "You can't choice anything one more",
                                margin: EdgeInsets.only(top: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!),
                              );
                            }
                          },
                          child: !UserHelper.selectedTopics.contains(topicListController.topicList[index]) ? Container(
                            padding: EdgeInsets.all(SizeConfig.defaultSize! * 0.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.black.withOpacity(.05),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              topicListController.topicList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: SizeConfig.defaultSize! * 1.75,
                              ),
                            ),
                          ) :
                          Container(
                            padding: EdgeInsets.all(SizeConfig.defaultSize! * 0.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.green,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              topicListController.topicList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: SizeConfig.defaultSize! * 1.75,
                              ),
                            ),
                          ),
                        );
                      },
                    ) : const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ),
            )
          ],
        ),
      )
    );
  }

  AppBar step2SignUpAppBar(){
    return AppBar(
      leading: IconButton(
        onPressed: (){
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.black,
          size: SizeConfig.defaultSize! * 3.5,
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: (){
              String message = _controlUser();
              if(message == "ok"){
                RouteHelper.goSignUpStep3();
              }
              else {
                Get.snackbar(
                    "Warning",
                    message,
                    margin: EdgeInsets.only(top: SizeConfig.defaultSize!, left: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!),
                    backgroundColor: AppColors.red.withOpacity(.25),
                    colorText: AppColors.white
                );
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                  color: AppColors.black.withOpacity(.5),
                  fontSize: SizeConfig.defaultSize! * 2
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.defaultSize! * 2,)
      ],
    );
  }


  String _controlUser(){
    if(UserHelper.selectedTopics.length != 10){
      return "select more";
    }
    else {
      return "ok";
    }
  }
}
