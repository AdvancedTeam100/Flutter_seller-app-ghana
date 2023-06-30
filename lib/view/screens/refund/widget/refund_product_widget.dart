import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';

class RefundProductWidget extends StatelessWidget {
  final RefundModel refundModel;
  final String variation;
  const RefundProductWidget({Key key, this.refundModel, this.variation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Stack(
          children: [
            Container(width: Dimensions.image_size, height: Dimensions.image_size,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                  child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}/'
                      '${refundModel.product.thumbnail}',width: Dimensions.image_size, height: Dimensions.image_size, fit: BoxFit.cover,)
              ) ,
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),),),
          ],
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


        Consumer<RefundProvider>(
            builder: (context, refund, _) {
              return refund.refundDetailsModel != null ?
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('${refundModel.product.name.toString()}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context),
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),),

                  Row( mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(height: Dimensions.ICON_SIZE_SMALL, width: Dimensions.ICON_SIZE_SMALL,

                        child: Image.asset(Images.order_pending_icon),),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child: Text(getTranslated(refundModel.status, context),
                            style: robotoRegular.copyWith(color: ColorResources.getPrimary(context))),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  Row(children: [
                    Container(height: Dimensions.ICON_SIZE_DEFAULT, width: Dimensions.ICON_SIZE_DEFAULT,
                      child: Image.asset(refundModel.paymentInfo == 'cash_on_delivery'? Images.cash_payment_icon:
                      refundModel.paymentInfo == 'pay_by_wallet'? Images.pay_by_wallet_icon : Images.digital_payment_icon),),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Text( (refundModel.paymentInfo == 'pay_by_wallet' || refundModel.paymentInfo == 'cash_on_delivery')?
                    getTranslated(refundModel.paymentInfo, context): getTranslated('digital_payment', context),
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).hintColor)),
                  ],),

                  (variation != null && variation.isNotEmpty) ?
                  Padding(padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text(variation,
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).disabledColor,)),
                  ) : SizedBox(),

                ],),):SizedBox();
            }),]),
    );
  }
}
