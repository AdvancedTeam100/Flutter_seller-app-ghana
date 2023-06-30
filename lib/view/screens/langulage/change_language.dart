import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'widget/language_widget.dart';

class ChooseLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('language', context)),

      body: Consumer<LocalizationProvider>(
        builder: (context,localizationController,_) {
          return Column(children: [
            SingleChildScrollView(physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: SizedBox(width: MediaQuery.of(context).size.width,
                child: Column(mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start, children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(child: SizedBox(width: 200, child: Image.asset(Images.logo_with_app_name))),
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text(getTranslated('select_language', context), style: robotoMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    )),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                    ),
                    itemCount: localizationController.languages.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LanguageWidget(
                      languageModel: localizationController.languages[index],
                      localizationController: localizationController,
                      index: index,
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                ],
              ),
            ),
          ),
        ]);
      },),
    );
  }
}
