import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class ShippingAndBillingWidget extends StatelessWidget {
  final Order orderModel;
  final bool onlyDigital;
  const ShippingAndBillingWidget({Key key, this.orderModel, this.onlyDigital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      if(!onlyDigital)Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_MEDIUM),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)

        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: Image.asset(Images.show_on_map,color: ColorResources.getTextColor(context), width: Dimensions.ICON_SIZE_SMALL ),
              ),
              Text(getTranslated('shipping_address', context),
                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                    color: ColorResources.titleColor(context),)),
            ],
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Text('${orderModel.shippingAddressData != null ?
          jsonDecode(orderModel.shippingAddressData)['address']  :
          orderModel.shippingAddress ?? ''}',
              style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),

        ],
      ),),

      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_MEDIUM),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: ThemeShadow.getShadow(context)

        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: Image.asset(Images.show_on_map,color: ColorResources.getTextColor(context), width: Dimensions.ICON_SIZE_SMALL ),
              ),
              Text(getTranslated('billing_address', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.titleColor(context),)),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Text('${orderModel.billingAddressData != null ?
          orderModel.billingAddressData.address.trim() :
          orderModel.billingAddress ?? ''}', style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),

        ],),
      ),

    ]);
  }
}
