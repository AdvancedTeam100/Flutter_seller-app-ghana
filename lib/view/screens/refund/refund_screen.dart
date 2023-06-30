import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_widget.dart';

class RefundScreen extends StatelessWidget {
  final bool isBacButtonExist;
  RefundScreen({this.isBacButtonExist = false});

  @override
  Widget build(BuildContext context) {
    Provider.of<RefundProvider>(context, listen: false).getRefundList(context);

    return Scaffold(
      body: Consumer<RefundProvider>(builder: (context, refund, child) {
        List<RefundModel> refundList = [];
        if (refund.refundTypeIndex == 0) {
          refundList = refund.pendingList;
        }else if (refund.refundTypeIndex == 1) {
          refundList = refund.approvedList;
        }else if (refund.refundTypeIndex == 2) {
          refundList = refund.deniedList;
        }else if (refund.refundTypeIndex == 3) {
          refundList = refund.doneList;
        }
        return Column(
          children: [
            CustomAppBar(title: getTranslated('refund_request', context), isBackButtonExist: isBacButtonExist),

            refund.pendingList != null ? Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
              child: SizedBox(
                height: 40,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [

                    RefundTypeButton(text: getTranslated('pending', context), index: 0, refundList: refund.pendingList),
                    SizedBox(width: 5),
                    RefundTypeButton(text: getTranslated('approved', context), index: 1, refundList: refund.approvedList),
                    SizedBox(width: 5),
                    RefundTypeButton(text: getTranslated('rejected', context), index: 2, refundList: refund.deniedList),
                    SizedBox(width: 5),
                    RefundTypeButton(text: getTranslated('refunded', context), index: 3, refundList: refund.doneList),
                    SizedBox(width: 5),

                  ],
                ),
              ),
            ) : SizedBox(),

            refund.pendingList != null ? refundList.length > 0?
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await refund.getRefundList(context);
                }, child: ListView.builder(
                  itemCount: refundList.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) => RefundWidget(refundModel : refundList[index]),
                ),
              ),
            ) :Expanded(child: NoDataScreen(title: 'no_refund_request_found')) : Expanded(child: OrderShimmer()),
          ],
        );
      },
      ),
    );
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RefundTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final List<RefundModel> refundList;
  RefundTypeButton({@required this.text, @required this.index, @required this.refundList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<RefundProvider>(context, listen: false).setIndex(index),
      child: Consumer<RefundProvider>(builder: (context, refund, child) {
        return Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: refund.refundTypeIndex == index ? Theme.of(context).primaryColor : ColorResources.getButtonHintColor(context),
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_LARGE),
          ),
          child: Text(text, style: refund.refundTypeIndex == index ? titilliumBold.copyWith(color: refund.refundTypeIndex == index
              ? ColorResources.getWhite(context) : ColorResources.getTextColor(context)):
          robotoRegular.copyWith(color: refund.refundTypeIndex == index
              ? ColorResources.getWhite(context) : ColorResources.getTextColor(context))),
        );
      },
      ),
    );
  }
}
