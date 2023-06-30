import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';



class ShopInformationWidget extends StatelessWidget {
  final ShopProvider resProvider;
  const ShopInformationWidget({Key key, this.resProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = 90;
    double reviewIconSize = 15;
    return resProvider.shopModel != null?
    Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
      child: Column(
        children: [
          Row(crossAxisAlignment :CrossAxisAlignment.start, children: [
            Column(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, -55, 0),
                  width: imageSize, height: imageSize,
                  decoration: BoxDecoration(
                    boxShadow: ThemeShadow.getShadow(context),
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                    child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).
                    baseUrls.shopImageUrl}/${resProvider.shopModel?.image}'),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


              ],
            ),

            SizedBox(width: Dimensions.PADDING_SIZE_MEDIUM),


            Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${resProvider.shopModel?.name ?? ''}',
                  style: robotoBold.copyWith(color: ColorResources.getTextColor(context),
                      fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM),

                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.ICON_SIZE_DEFAULT,
                        child:Image.asset(Images.shop_address)),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Text('${resProvider.shopModel?.address ?? ''}',
                        style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context)), maxLines: 2,
                        overflow: TextOverflow.ellipsis,softWrap: false,),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM),

                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.ICON_SIZE_DEFAULT,
                        child:Image.asset(Images.shop_phone)),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Text('${resProvider.shopModel?.contact ?? ''}',
                        style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context)), maxLines: 2,
                        overflow: TextOverflow.ellipsis,softWrap: false,),
                    ),
                  ],
                ),


              ],),),

          ],),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [Container(width: Dimensions.ICON_SIZE_SMALL, height: Dimensions.ICON_SIZE_SMALL,
                      child: Image.asset(Images.star)),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                    Text('${resProvider.shopModel?.ratting?.toDouble()?.toStringAsFixed(1) ?? ''}',
                      style: robotoTitleRegular.copyWith(color: ColorResources.getTextColor(context),
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                  ],),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(width: reviewIconSize,child: Image.asset(Images.shop_review)),
                  ),
                  Row(children: [
                    Text('${NumberFormat.compact().format(resProvider.shopModel?.rattingCount)}',
                      style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                    Text(getTranslated('reviews', context),
                      style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                  ],)
                ],),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: SizedBox(width: reviewIconSize,
                        child: Image.asset(Images.shop_product)),
                  ),
                  Row(children: [


                    Consumer<ProfileProvider>(
                        builder: (context, profile,_) {
                          return Text('${NumberFormat.compact().format(profile.userInfoModel.productCount)}',
                            style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                                fontSize: Dimensions.FONT_SIZE_DEFAULT),);
                        }
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                    Text(getTranslated('products', context),
                      style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),)
                  ],)
                ],)


            ],),
          )
        ],
      ),
    ):CustomLoader();
  }
}

