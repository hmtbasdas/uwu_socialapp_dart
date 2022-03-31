import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:uwusocialapp/helper/user_helper.dart';
import '../../../../controller/country_list_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/size_config.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryListController>(
      builder: (countryList){
        return countryList.isLoaded ? DropdownButtonFormField(
          isExpanded: true,
          items: countryList.allCountryList.map((item) =>
              DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  style: TextStyle(
                      fontSize: SizeConfig.defaultSize! * 2
                  ),
                ),
                onTap: (){
                  UserHelper.selectedCountry = item;
                },
              ),
          ).toList(),
          onChanged: (item){

          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black.withOpacity(.5),
                ),
              ),
              labelText: "Country"
          ),
        ) : Text(
          "countries are loading",
          style: TextStyle(
              color: AppColors.black.withOpacity(.5)
          ),
        );
      },
    );
  }
}
