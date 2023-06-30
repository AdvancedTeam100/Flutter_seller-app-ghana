

import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

class ApproveAndDenyWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function onYesPressed;
  final TextEditingController note;
  final bool isApprove;
  const ApproveAndDenyWidget({Key key, this.icon, this.title, this.onYesPressed, this.note, this.isApprove = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
        insetPadding: EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(width: 500, child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(mainAxisSize: MainAxisSize.min, children: [

              Padding(
                padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL,
                bottom: Dimensions.PADDING_SIZE_LARGE),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Image.asset(icon,width: Dimensions.LOGO_HEIGHT,),
                ),
              ),

              title != null ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  title, textAlign: TextAlign.center,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
              ) : SizedBox(),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: CustomTextField(
                  border: true,
                  hintText: getTranslated('note', context),
                  controller: note,
                  maxLine: 3,


                ),
              ),


              CustomButton(
                btnTxt: getTranslated('submit',context),
                onTap: () =>  onYesPressed(),
              )
            ])),
        ));
  }
}
