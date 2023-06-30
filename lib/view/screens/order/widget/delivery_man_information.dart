import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/order_setup.dart';

class DeliveryManContactInformation extends StatelessWidget {
  final String orderType;
  final Order orderModel;
  final bool onlyDigital;
  const DeliveryManContactInformation({Key key, this.orderModel, this.orderType, this.onlyDigital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_MEDIUM),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: ThemeShadow.getShadow(context)

          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(getTranslated('deliveryman_information', context),
                style: robotoMedium.copyWith(color: ColorResources.titleColor(context),
                  fontSize: Dimensions.FONT_SIZE_LARGE,)),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


            Row(children: [ClipRRect(borderRadius: BorderRadius.circular(50),
                child: CustomImage( height: 50,width: 50, fit: BoxFit.cover,
                    image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.deliveryManImageUrl}/${orderModel.deliveryMan.image}')),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${orderModel.deliveryMan.fName ?? ''} ''${orderModel.deliveryMan.lName ?? ''}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                Text('${orderModel.deliveryMan.phone}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.FONT_SIZE_DEFAULT)),


                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                Text('${orderModel.deliveryMan.email ?? ''}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.FONT_SIZE_DEFAULT)),

              ],))
            ],
            )
          ]),
        ),
      ],
    );
  }
}
