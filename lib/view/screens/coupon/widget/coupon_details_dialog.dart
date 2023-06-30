import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/coupon_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CouponDetailsDialog extends StatelessWidget {
  final Coupons coupons;
  const CouponDetailsDialog({Key key, this.coupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double circleSize = 90;
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Stack(
        children: [
          Container(
            child: Center(
              child: Stack(
                children: [
                  Container(height: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_MEDIUM),
                        bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_MEDIUM))
                    ),
                    child: Row(children: [
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_MEDIUM),
                                bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_MEDIUM))
                        ),
                      )),
                      Container(width: 10,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiaryContainer
                        ),
                      ),
                      Container(width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.PADDING_SIZE_MEDIUM),
                              bottomRight: Radius.circular(Dimensions.PADDING_SIZE_MEDIUM))
                      ),),
                    ],),
                  ),
                  Column(mainAxisSize: MainAxisSize.min,
                    children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_MEDIUM,Dimensions.PADDING_SIZE_SMALL,Dimensions.PADDING_SIZE),
                        child: Container(
                          width: circleSize,height: circleSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 6,color: Theme.of(context).colorScheme.tertiaryContainer)
                          ),
                          child: coupons.couponType == 'free_delivery'?
                              Padding(
                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                child: Image.asset(Images.free_delivery,width: 40,),
                              ):
                          Center(child: coupons.discountType == 'amount'?
                          Column(mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(PriceConverter.convertPrice(context, coupons.discount),
                                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(getTranslated('off', context),
                                  style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                            ],
                          ):
                          Column(mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${coupons.discount}%',
                                  style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),

                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                              Text(getTranslated('off', context),
                                  style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                            ],
                          )
                          ),
                        ),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coupons.title, style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,color: ColorResources.getTextTitle(context))),
                          SizedBox(height: Dimensions.PADDING_EYE),
                          Text('${getTranslated('code', context)} : ${coupons.code}',
                            style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getTextTitle(context))),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Text(getTranslated(coupons.couponType, context)),
                        ],
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Container(child: Column(children: [
                        Row(children: [
                          Text('${getTranslated('minimum_purchase', context)} : '),
                          Text(PriceConverter.convertPrice(context, coupons.minPurchase), style: robotoBold,),
                        ],),
                        SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,),
                        Row(children: [
                          Text('${getTranslated('maximum_discount', context)} : '),
                          Text(PriceConverter.convertPrice(context, coupons.minPurchase), style: robotoBold,),
                        ],),
                        SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,),
                        Row(children: [
                          Text('${getTranslated('start_from', context)} : '),
                          Text(DateConverter.isoStringToDateTimeString(coupons.createdAt), style: robotoBold,),
                        ],),
                        SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,),
                        Row(children: [
                          Text('${getTranslated('expires_on', context)} : '),
                          Text(DateConverter.isoStringToDateTimeString(coupons.expireDate), style: robotoBold,),
                        ],),
                      ],),),
                    )
                  ],),


                ],
              ),
            ),
          ),
          Positioned(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: ()=> Navigator.pop(context),
                    child: Padding(
                      padding:  EdgeInsets.only(left:Dimensions.PADDING_SIZE_SMALL,
                          right:Dimensions.PADDING_SIZE_SMALL,
                          bottom: MediaQuery.of(context).size.height/3.9),
                      child: SizedBox(child: Icon(Icons.clear, color: Colors.white),),
                    ),
                  ))),
        ],
      ),
    );
  }
}
