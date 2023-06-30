import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CustomFieldWithTitle extends StatelessWidget {
  final Widget customTextField;
  final String title;
  final bool requiredField;
  final bool isPadding;
  final bool isSKU;
  final bool limitSet;
  final String setLimitTitle;
  final Function onTap;
  final bool isCoupon;
  const CustomFieldWithTitle({
    Key key,
    @required this.customTextField,
    this.title,
    this.setLimitTitle,
    this.requiredField = false,
    this.isPadding = true,
    this.isSKU = false,
    this.limitSet = false,
    this.onTap, this.isCoupon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isCoupon? EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL): isPadding ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title, style: robotoRegular.copyWith(color: ColorResources.getTextColor(context)),
                children: <TextSpan>[
                 requiredField ? TextSpan(text: '  *', style: robotoRegular.copyWith(color: Colors.red)) : TextSpan(),
                ],
              ),
            ),
         ],
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        
        customTextField,
      ],),
    );
  }
}
