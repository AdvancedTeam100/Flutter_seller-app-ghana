import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/repository/ratting_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/image_diaglog.dart';


class ReviewWidget extends StatelessWidget {
  final int index;
  final Reviews reviewModel;
  final bool isDetails;
  ReviewWidget({@required this.reviewModel, this.isDetails = false, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
          spreadRadius: 0.5, blurRadius: 0.3)],
        ),

        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    child: Container(
                      width: Dimensions.stock_out_image_size,
                      height: Dimensions.stock_out_image_size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
                            spreadRadius: 0.5, blurRadius: 0.3)],

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
                        child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                          baseUrls.productThumbnailUrl}/${reviewModel.product.thumbnail}',)

                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Text(getTranslated(reviewModel.product.productType, context), style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

            Flexible(flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    reviewModel.customer != null?
                    Text('${reviewModel.customer.fName ?? ''}' '${reviewModel.customer.lName ?? ''}',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                        maxLines: 1, overflow: TextOverflow.ellipsis):SizedBox(),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                    Text(reviewModel.product.name ?? '',
                        style: robotoRegular.copyWith(color: ColorResources.titleColor(context)),
                        maxLines: 1, overflow: TextOverflow.ellipsis),



                    Row(children: [
                      Icon(Icons.star, color: Provider.of<ThemeProvider>(context).darkTheme ?
                          Colors.white : Colors.orange, size: Dimensions.ICON_SIZE_DEFAULT),

                      Text('${reviewModel.rating.toDouble().toStringAsFixed(1)}/5'),

                      Spacer(),


                      Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(reviewModel.createdAt)),)

                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                    Text(reviewModel.comment ?? '',
                      style: robotoHintRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      maxLines: isDetails ? 100: 2, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    (reviewModel.attachment != null && reviewModel.attachment.length > 0) ? Padding(
                      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: reviewModel.attachment.length,
                          itemBuilder: (context, index) {
                            String imageUrl = '${Provider.of<SplashProvider>(context, listen: false).baseUrls.reviewImageUrl}/review/${reviewModel.attachment[index]}';
                            return InkWell(
                              onTap: () => showDialog(context: context, builder: (ctx) =>
                                  ImageDialog(imageUrl:imageUrl), ),
                              child: Container(
                                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder_image, height: 40, width: 40, fit: BoxFit.cover,
                                    image: imageUrl,
                                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_image, height: 40, width: 40, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ) : SizedBox(),


                  ],),
              ),
            )

          ],),
      ),
    );

  }
}
