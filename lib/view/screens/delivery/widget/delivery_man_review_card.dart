import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_review_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';



class DeliveryManReviewItem extends StatelessWidget {
  final DeliveryManReview reviewModel;
  const DeliveryManReviewItem({Key key, @required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('--------bb-------->${reviewModel.customer.fName}');
    String baseUrl = '${Provider.of<SplashProvider>(context, listen: false).configModel.baseUrls.customerImageUrl}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.07), blurRadius: 1,spreadRadius: 1)]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if(reviewModel.customer != null)
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
                    child: Container(
                      width: Dimensions.PRODUCT_IMAGE_SIZE,
                      height: Dimensions.PRODUCT_IMAGE_SIZE,
                      child: CustomImage(image:"$baseUrl/${reviewModel.customer.image}"),
                    ),
                  ),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reviewModel.customer != null?
                            Text(reviewModel.customer.fName + " " + reviewModel.customer.lName,
                              style: robotoMedium.copyWith(),
                            ):Text(getTranslated('customer_not_available', context),
                            style: robotoMedium.copyWith(),),


                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Row(children: [
                            SizedBox(width: Dimensions.ICON_SIZE_SMALL,
                                child: Image.asset(Images.ratting)),

                            Padding(padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Text(reviewModel.rating.toString(),
                                    style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),
                          ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL, bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Row(children: [
                              Text('${getTranslated('order_id', context)}# '),
                              Text(reviewModel.orderId.toString(),style: robotoBold,),
                            ],),
                          )

                        ])),
                Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(reviewModel.createdAt)),)
              ],
            ),

            Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,top : Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Text(reviewModel.comment,
                  style: robotoRegular.copyWith(),
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    );
  }
}
