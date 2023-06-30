import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderTypeButtonHead extends StatelessWidget {
  final String text;
  final String subText;
  final Color color;
  final int index;
  final Function callback;
  final int numberOfOrder;
  OrderTypeButtonHead({@required this.text,this.subText,this.color ,@required this.index, @required this.callback, @required this.numberOfOrder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderProvider>(context, listen: false).setIndex(context, index);
        callback();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),),
        color: color,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: Container(alignment: Alignment.center,
                child: Center(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(numberOfOrder.toString(),
                          style: robotoBold.copyWith(color: ColorResources.getWhite(context),
                              fontSize: Dimensions.FONT_SIZE_HEADER_LARGE)),

                      Row(children: [
                          Text(text, style: robotoRegular.copyWith(color: ColorResources.getWhite(context),
                              fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          Text(subText, style: robotoRegular.copyWith(color: ColorResources.getWhite(context))),
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Provider.of<LocalizationProvider>(context,listen: false).isLtr?SizedBox.shrink():Spacer(),
                Container(width: MediaQuery.of(context).size.width/4,
                  height:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.10),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
                  ),),
                Provider.of<LocalizationProvider>(context,listen: false).isLtr?Spacer():SizedBox.shrink(),
              ],
            )


          ],
        ),
      ),
    );
  }
}
