import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class ProductCalculationItem extends StatelessWidget {
  final String title;
  final double price;
  final bool isQ;
  const ProductCalculationItem({Key key, this.title, this.price, this.isQ = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      isQ?
      Text('${getTranslated(title, context)} (x 1)',
          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))):
      Text('${getTranslated(title, context)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))),
      Spacer(),
      Text('-${PriceConverter.convertPrice(context, price)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: ColorResources.titleColor(context))),
    ],);
  }
}