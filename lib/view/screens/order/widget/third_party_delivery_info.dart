import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';




class ThirdPartyDeliveryInfo extends StatelessWidget {
  final Order orderModel;
  const ThirdPartyDeliveryInfo({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_MEDIUM),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)

      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(getTranslated('third_party_information', context),
            style: robotoMedium.copyWith(color: ColorResources.titleColor(context),
              fontSize: Dimensions.FONT_SIZE_LARGE,)),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


        Row(children: [ClipRRect(borderRadius: BorderRadius.circular(50),
            child: CustomImage( height: 50,width: 50, fit: BoxFit.cover,
                image: '')),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),



          Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${orderModel.thirdPartyServiceName ?? ''} }',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT)),

            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text('${orderModel.thirdPartyTrackingId}',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT)),


          ],))
        ],
        )
      ]),
    );
  }
}
