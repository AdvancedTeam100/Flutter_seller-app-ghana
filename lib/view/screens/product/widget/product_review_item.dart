import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/review_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/image_diaglog.dart';
import 'package:sixvalley_vendor_app/view/base/rating_bar.dart';



class ProductReviewItem extends StatelessWidget {

  final ReviewModel reviewModel;
  const ProductReviewItem({Key key, @required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = '${Provider.of<SplashProvider>(context, listen: false).configModel.baseUrls.customerImageUrl}';
    String review = '${Provider.of<SplashProvider>(context, listen: false).configModel.baseUrls.reviewImageUrl}';
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
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
                        if(reviewModel.customer != null)
                        Text(reviewModel.customer.fName + " " + reviewModel.customer.lName,
                          style: robotoMedium.copyWith(),
                        ),
                        if(reviewModel.customer == null)
                          Text(getTranslated('customer_not_available', context),
                          style: robotoMedium.copyWith(),),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                            RatingBar(rating: reviewModel.rating),

                          Padding(padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(reviewModel.rating.toString(),
                              style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),
                          ],
                        ),
                      ])),
              Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(reviewModel.createdAt)),)
            ],
          ),

          Padding(
              padding: const EdgeInsets.only(left: 2,top : Dimensions.PADDING_SIZE_EXTRA_SMALL, bottom: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(reviewModel.comment??'',
                style: robotoRegular.copyWith(),
                textAlign: TextAlign.start,
              )),

          reviewModel.attachment.isNotEmpty?
          Container(height: Dimensions.PRODUCT_IMAGE_SIZE,
            child: ListView.builder(
                itemCount: reviewModel.attachment.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () => showDialog(context: context, builder: (ctx) =>
                        ImageDialog(imageUrl:'$review/review/${reviewModel.attachment[index]}')),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Container(decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                          width: Dimensions.PRODUCT_IMAGE_SIZE,height: Dimensions.image_size,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: CustomImage(image: '$review/review/${reviewModel.attachment[index]}',
                              width: Dimensions.PRODUCT_IMAGE_SIZE,height: Dimensions.PRODUCT_IMAGE_SIZE,),
                          )),
                    ),
                  );
                }),):SizedBox()

        ],
      ),
    );
  }
}
