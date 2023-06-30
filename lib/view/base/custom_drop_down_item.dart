
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CustomDropDownItem extends StatelessWidget {
  final String title;
  final Widget widget;
  const CustomDropDownItem({Key key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [

        title != null?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(getTranslated(title, context), style: robotoRegular,),
        ):SizedBox(),

        Padding(padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_DEFAULT,0),
          child: Container(height: 45,
            padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,
                right: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.5))
            ),
            alignment: Alignment.center,
            child: widget,
          ),),
        SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM)
      ],),
    );
  }
}