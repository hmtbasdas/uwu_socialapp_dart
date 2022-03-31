import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uwusocialapp/data/firebase/database_services/firestore_services.dart';
import 'package:uwusocialapp/helper/filters.dart';
import 'package:uwusocialapp/screens/home/screens/user_details_screen.dart';
import 'package:uwusocialapp/utils/colors.dart';
import 'package:uwusocialapp/utils/size_config.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {

  @override
  void initState() {
    Get.find<FirestoreService>().getUsersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
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
                _matchesBottomModalFilter();
              },
              icon: Icon(Icons.filter_list_rounded, color: AppColors.black,),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: GetBuilder<FirestoreService>(
            builder: (firestoreService){
              return firestoreService.listUsers.isNotEmpty ? GridView.builder(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5, right: SizeConfig.defaultSize! * 1.5, top: SizeConfig.defaultSize! * .75, bottom: SizeConfig.defaultSize! * 1.5),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3/4,
                ),
                itemCount: firestoreService.listUsers.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => UserDetailsScreen(appUser: firestoreService.listUsers[index],)
                      ));
                    },
                    child: Card(
                      color: AppColors.white,
                      elevation: 20,
                      shadowColor: AppColors.black.withOpacity(.5),
                      child: Container(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * .5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              (DateTime.now().year - firestoreService.listUsers[index].birthday.toDate().year).toString(),
                              style: TextStyle(
                                color: AppColors.black.withOpacity(.5),
                                fontSize: SizeConfig.defaultSize! * 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Hero(
                                    tag: firestoreService.listUsers[index].id,
                                    child: SvgPicture.network(
                                      firestoreService.listUsers[index].avatar,
                                      width: SizeConfig.defaultSize! * 7.5,
                                      height: SizeConfig.defaultSize! * 7.5,
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize!,),
                                  Text(
                                    firestoreService.listUsers[index].nickname,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      fontSize: SizeConfig.defaultSize! * 2,
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize!,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: firestoreService.listUsers[index].country.length > 20 ? firestoreService.listUsers[index].country.substring(0,10) + "..." : firestoreService.listUsers[index].country,
                                          style: TextStyle(
                                              color: AppColors.black.withOpacity(.5),
                                              fontSize: SizeConfig.defaultSize! * 1.2,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: SizeConfig.defaultSize! * .5,),
                                      SvgPicture.network(
                                        "https://countryflagsapi.com/svg/${firestoreService.listUsers[index].country.toLowerCase().replaceAll(' ', '%20')}",
                                        height: SizeConfig.defaultSize!,
                                        width: SizeConfig.defaultSize!,
                                      )
                                    ],
                                  ),
                                  Divider(height: SizeConfig.defaultSize! * 4, indent: SizeConfig.defaultSize! * 2, endIndent: SizeConfig.defaultSize! * 2, color: AppColors.black.withOpacity(.5),),
                                  Text(
                                    _matchedCounter(firestoreService, index),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.defaultSize! * 1.5,
                                        color: AppColors.black
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) : firestoreService.isLoaded ?
              const Center(
                child: CircularProgressIndicator(),
              ) : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "gifs/empty.json",
                      height: SizeConfig.defaultSize! * 25,
                      width:  SizeConfig.defaultSize! * 25,
                    ),
                    Text(
                      "Why is empty here ?",
                      style: TextStyle(
                        color: AppColors.black.withOpacity(.5),
                        fontSize: SizeConfig.defaultSize! * 2
                      ),
                    ),
                  ],
                )
              );
            },
          )
        ),
      ),
    );
  }

  Future _refresh() async {
    debugPrint("refreshed");
    setState(() {
      Get.find<FirestoreService>().getUsersData();
    });
  }

  void _matchesBottomModalFilter(){
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
                padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.6, right: SizeConfig.defaultSize! * 1.6, top: SizeConfig.defaultSize! * 1.6),
                margin: MediaQuery.of(context).viewInsets,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(SizeConfig.defaultSize! * 2), topRight: Radius.circular(SizeConfig.defaultSize! * 2)),
                  color: AppColors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        _refresh();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filters",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize! * 3,
                              color: AppColors.black,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: SizeConfig.defaultSize! * .75, right: SizeConfig.defaultSize! * .75, top: SizeConfig.defaultSize! * .5, bottom: SizeConfig.defaultSize! * .5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeConfig.screenHeight!),
                                  color: AppColors.green.withOpacity(.5)
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Apply",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: SizeConfig.defaultSize! * 1.5
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.defaultSize!,),
                                  Icon(
                                    Icons.save_rounded,
                                    color: AppColors.white,
                                    size: SizeConfig.defaultSize! * 1.5,
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                    Divider(color: AppColors.black.withOpacity(.25), thickness: .5,),
                    SizedBox(height: SizeConfig.defaultSize! * 1.5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              color: AppColors.blue.withOpacity(.5),
                              size: SizeConfig.defaultSize! * 3,
                            ),
                            SizedBox(width: SizeConfig.defaultSize! * 1.5,),
                            Text(
                              "Only my country members",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: SizeConfig.defaultSize! * 1.5
                              ),
                            )
                          ],
                        ),
                        Switch(
                          value: Filters.countryValue,
                          onChanged: (bool newValue){
                            setState(() {
                              Filters.countryValue = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.defaultSize!,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              color: AppColors.blue.withOpacity(.5),
                              size: SizeConfig.defaultSize! * 3,
                            ),
                            SizedBox(width: SizeConfig.defaultSize! * 1.5,),
                            Text(
                              "Age Range",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: SizeConfig.defaultSize! * 1.5
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "18 - ",
                              style: TextStyle(
                                color: AppColors.black.withOpacity(.5),
                                fontSize: SizeConfig.defaultSize! * 2
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.defaultSize! * 6,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: Filters.ageRangeController,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "99",
                                ),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: SizeConfig.defaultSize! * 2,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.defaultSize!,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_pin_outlined,
                              color: AppColors.blue.withOpacity(.5),
                              size: SizeConfig.defaultSize! * 3,
                            ),
                            SizedBox(width: SizeConfig.defaultSize! * 1.5,),
                            Text(
                              "Gender",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: SizeConfig.defaultSize! * 1.5
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: Filters.maleValue,
                                    onChanged: (bool? newValue){
                                      setState(() {
                                        Filters.maleValue = newValue!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "male",
                                    style: TextStyle(
                                        color: AppColors.black.withOpacity(.5)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: Filters.femaleValue,
                                    onChanged: (bool? newValue){
                                      setState(() {
                                        Filters.femaleValue = newValue!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "female",
                                    style: TextStyle(
                                        color: AppColors.black.withOpacity(.5)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.defaultSize!,),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }

  String _matchedCounter(FirestoreService firestoreService ,int index){

    int counter = 0;
    for(int i=0;i<10;i++){
     for(int j=0;j<10;j++){
       if(firestoreService.listUsers[index].topics[i] == firestoreService.currentUserValues.topics[j]){
         counter++;
       }
     }
    }
    return "Matched: $counter";
  }
}

