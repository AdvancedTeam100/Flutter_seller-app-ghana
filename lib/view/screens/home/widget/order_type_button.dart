import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderTypeButton extends StatelessWidget {
  final String text;
  final String icon;
  final int index;
  final Color color;
  final Function callback;
  final int numberOfOrder;
  final bool showBorder;
  OrderTypeButton({@required this.text,this.icon ,@required this.index, @required this.callback, @required this.numberOfOrder, this.color, this.showBorder = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderProvider>(context, listen: false).setIndex(context,index);
        callback();},

      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_SMALL,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null?
                  Container(width: Dimensions.ICON_SIZE_LARGE,
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
                      child: Text(numberOfOrder.toString(),
                          style: robotoRegular.copyWith(color : color)),
                    ),
                  )


                ],
              ),
            ),
          ),
          showBorder?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(.2)),
          ):SizedBox(),
        ],
      ),
    );
  }
}
