import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/repository/ratting_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_review_provider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/screens/review/widget/review_widget.dart';




class ReviewFullViewScreen extends StatelessWidget {
  final Reviews reviewModel;
  final bool isDetails;
  final int index;
  const ReviewFullViewScreen({Key key, this.reviewModel, this.isDetails, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title : getTranslated('review_details', context), isAction: true, isSwitch: true,
        index: index,
        reviewSwitch: true,
        switchAction: (value){
          if(value){
            Provider.of<ProductReviewProvider>(context, listen: false).reviewStatusOnOff(context, reviewModel.id, 1, index);
          }else{
            Provider.of<ProductReviewProvider>(context, listen: false).reviewStatusOnOff(context, reviewModel.id, 0, index);
          }

      },),
      body: ReviewWidget(reviewModel: reviewModel, isDetails: isDetails),
    );
  }
}
