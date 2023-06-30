import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_earning_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';


class EarningCardWidget extends StatelessWidget {
  final Earning earning;
  final int index;
  EarningCardWidget({@required this.earning, this.index});

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.09),blurRadius: 5, spreadRadius: 1, offset: Offset(1,2))]
          ),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_MEDIUM, horizontal: Dimensions.PADDING_SIZE_MEDIUM),
              child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('${getTranslated('order_no', context)}# ',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                      Text('${earning.id}',
                        style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(.125),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_EYE),
                      child: Text(PriceConverter.convertPrice(context, earning.deliverymanCharge),
                        style: robotoMedium.copyWith(color: Colors.green),),
                    ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
              child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(earning.updatedAt)),
                  style: titilliumRegular.copyWith(color: Theme.of(context).hintColor)),
            ),


            Container(decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                    bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                child: Column(children: [

                  Row( mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(height: Dimensions.ICON_SIZE_SMALL, width: Dimensions.ICON_SIZE_SMALL,

                        child: Image.asset(Images.order_pending_icon),),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child: Text(getTranslated(earning.orderStatus, context),
                            style: robotoRegular.copyWith(color: ColorResources.getPrimary(context))),
                      ),


                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                ],),
              ),)
          ],),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
          child: CustomDivider(height: .5,),
        )

      ],
    );
  }
}

