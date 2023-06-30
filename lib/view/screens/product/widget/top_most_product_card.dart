import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_details.dart';

class TopMostProductWidget extends StatelessWidget {
  final Product productModel;
  final bool isPopular;
  final String totalSold;
  const TopMostProductWidget({Key key, this.productModel, this.isPopular = false, this.totalSold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,0,Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: GestureDetector(
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailsScreen(productModel: productModel))),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).primaryColor.withOpacity(0):
            Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: Offset(1,2))]


          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Container(decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.10),
                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.width/2-50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: CachedNetworkImage(
                    placeholder: (ctx, url) => Image.asset(Images.placeholder_image,
                      height: Dimensions.image_size,width: Dimensions.image_size,fit: BoxFit.cover,),
                    fit: BoxFit.cover,
                    height: Dimensions.image_size,width: Dimensions.image_size,
                    errorWidget: (ctx,url,err) => Image.asset(Images.placeholder_image,fit: BoxFit.cover,
                      height: Dimensions.image_size,width: Dimensions.image_size,),
                    imageUrl: '${Provider.of<SplashProvider>(context, listen: false).
                    baseUrls.productThumbnailUrl}/${productModel.thumbnail}',),
                ),
              ),
            ),



            Padding(padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_EXTRA_SMALL, 0,Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Center(
                    child: Text(productModel.name.trim() ?? '',textAlign: TextAlign.center, style: robotoMedium.copyWith(
                        color: ColorResources.titleColor(context),fontSize: Dimensions.FONT_SIZE_DEFAULT),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                isPopular?
                Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${NumberFormat.compact().format(productModel.reviewsCount)}',
                      style: robotoMedium.copyWith(color: Theme.of(context).errorColor, fontSize: Dimensions.FONT_SIZE_LARGE),),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    SizedBox(width: Dimensions.ICON_SIZE_DEFAULT, child: Image.asset(Images.popular_product_icon))
                  ],
                ):
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                        color: Theme.of(context).errorColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                    ),
                    child: Text('${NumberFormat.compact().format(double.parse(totalSold))} ${getTranslated('sold', context)}',
                      style: robotoMedium.copyWith(color: Colors.white),),
                  ),
                )

              ],),
            ),
          ],),
        ),
      ),
    );
  }
}
