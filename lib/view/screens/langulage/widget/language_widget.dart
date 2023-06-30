import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/language_model.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationProvider localizationController;
  final int index;
  LanguageWidget({@required this.languageModel, @required this.localizationController, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
        boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
        Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200], blurRadius: 5, spreadRadius: 1)],
      ),
      child: GestureDetector(
        onTap: (){
          localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode,
            AppConstants.languages[index].countryCode,
          ), index);

        },

        child: Stack(children: [

          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(height: 65, width: 65,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                  border: Border.all(color: Theme.of(context).textTheme.bodyText1.color, width: 1)),
                alignment: Alignment.center,
                child: Image.asset(languageModel.imageUrl, width: 36, height: 36)),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Text(languageModel.languageName, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
            ]),
          ),

          localizationController.languageIndex == index ?
          Positioned(top: 10, right: 10,
            child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
          ) : SizedBox(),

        ]),
      ),
    );
  }
}
