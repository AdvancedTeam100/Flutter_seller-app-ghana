import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class BalanceStatementWidget extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  final double amount;
  const BalanceStatementWidget({Key key, this.text, this.icon, this.color, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null?
          Container(width: Dimensions.ICON_SIZE_DEFAULT,
              child: Image.asset(icon)): SizedBox(),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(text, style: robotoRegular.copyWith(color: ColorResources.getTextColor(context))),

          Spacer(),
          Container(decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_LARGE)
          ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Text(PriceConverter.convertPrice(context, amount),
                  style: robotoRegular.copyWith(color : color)),
            ),
          )


        ],
      ),
    );
  }
}
