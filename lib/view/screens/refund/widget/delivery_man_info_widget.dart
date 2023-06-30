import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class DeliveryManInfoWidget extends StatelessWidget {
  final RefundProvider refundReq;
  const DeliveryManInfoWidget({Key key, this.refundReq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
        boxShadow: ThemeShadow.getShadow(context),
       ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(getTranslated('deliveryman_contact_details', context),
            style: titilliumBold.copyWith(color: ColorResources.getTextColor(context))),
        SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM),

        Row(children: [ClipRRect(borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
              errorWidget: (ctx, url, err) => Image.asset(Images.placeholder_image, height: 50,width: 50, fit: BoxFit.cover),
              placeholder: (ctx, url) => Image.asset(Images.placeholder_image,height: 50,width: 50, fit: BoxFit.cover),
              imageUrl: '${Provider.of<SplashProvider>(context, listen: false).
              baseUrls.deliveryManImageUrl}/${refundReq.refundDetailsModel.deliverymanDetails.image}',
              height: 50,width: 50, fit: BoxFit.cover),),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),



          Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text('${refundReq.refundDetailsModel.deliverymanDetails.fName ?? ''} '
                '${refundReq.refundDetailsModel.deliverymanDetails.lName ?? ''}',
                style: robotoMedium.copyWith(color: ColorResources.getTextColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT)),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

            Text('${refundReq.refundDetailsModel.deliverymanDetails.phone}',
                style: robotoRegular.copyWith(color: ColorResources.getHintColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT)),

            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

            Text('${refundReq.refundDetailsModel.deliverymanDetails.email ?? ''}',
                style: robotoRegular.copyWith(color: ColorResources.getHintColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT)),



          ],
          ))
        ],
        )
      ]),
    );
  }
}
