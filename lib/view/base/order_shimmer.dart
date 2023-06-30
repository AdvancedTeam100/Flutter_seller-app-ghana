import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderShimmer extends StatelessWidget {
  final bool isEnabled;
  OrderShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10, spreadRadius: 1)],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: isEnabled,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' ${getTranslated('order_no', context)} : #', style: titilliumBold.copyWith(color: ColorResources.COLOR_LIGHT_BLACK,fontSize: 14),),
                  Text('\$0.00', style: titilliumBold.copyWith(color: ColorResources.GAINS_BORO,fontSize: 14)),
                ]
            ),
            Row(children: [
              Text('00:00', style: titilliumRegular.copyWith(color: ColorResources.GAINS_BORO,fontSize: 10)),
              SizedBox(width: 5),
              Text('|', style: TextStyle(color: ColorResources.GAINS_BORO),),
              SizedBox(width: 5),
              Text('1 items : item',
                  style: titilliumRegular.copyWith(color: ColorResources.GAINS_BORO,fontSize: 10)),
            ],),

            Container(height: 2, margin: EdgeInsets.all(5), color: ColorResources.GREY,),

            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: ColorResources.GAINS_BORO,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Name', style: titilliumBold.copyWith(color: ColorResources.GAINS_BORO,fontSize: 15))),
                Expanded(child: SizedBox()),
                Text('${getTranslated('view_details', context)}', style: titilliumRegular.copyWith(color: ColorResources.GAINS_BORO,fontSize: 12),),
                Icon(Icons.arrow_forward_outlined, color: ColorResources.GAINS_BORO,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
