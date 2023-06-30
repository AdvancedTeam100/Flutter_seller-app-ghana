import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/refund_details_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_attachment_list.dart';

class RefundWidget extends StatelessWidget {
  final RefundModel refundModel;
  final bool isDetails;
  RefundWidget({@required this.refundModel, this.isDetails = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDetails? null:() => Navigator.push(context, MaterialPageRoute(builder: (_) => RefundDetailsScreen(
          refundModel: refundModel, orderDetailsId: refundModel.orderDetailsId,
          variation: refundModel.orderDetails.variant))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_MEDIUM),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
            Theme.of(context).hintColor.withOpacity(.25), blurRadius: 2, spreadRadius: 2, offset: Offset(1,2))]
          ),

          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_MEDIUM, vertical: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                  topLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                  bottomRight: Radius.circular(Dimensions.PADDING_SIZE_VERY_TINY),
                  bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_VERY_TINY),
              )
            ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.05),
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                    ),
                    child: Row(
                      children: [
                        Text('${getTranslated('order_no', context)}# ',
                          style: robotoRegular.copyWith(color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.FONT_SIZE_LARGE),),

                        Text(' ${refundModel.orderId.toString()}',
                          style: robotoMedium.copyWith(color: ColorResources.getTextColor(context),
                              fontSize: Dimensions.FONT_SIZE_LARGE),),
                      ],
                    ),
                  ),

                  refundModel.product != null?
                  Container(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                  ),
                    child: Text(PriceConverter.convertPrice(context, refundModel.product?.unitPrice),
                      style: robotoMedium.copyWith(color: Colors.white,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  ):SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_MEDIUM,bottom: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_MEDIUM),
              child: Text('${getTranslated('requested_on', context)} : ${DateConverter.localDateToIsoStringAMPM(DateTime.parse(refundModel.createdAt))}',
                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_ORDER, vertical: Dimensions.PADDING_SIZE_SMALL),

              child: refundModel != null ?
              Row(children: [
                refundModel.product != null?
                Container(
                  width: Dimensions.stock_out_image_size, height: Dimensions.stock_out_image_size,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL),),
                    child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}/'
                        '${refundModel.product.thumbnail}',)

                  ) ,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL))),
                ):SizedBox(),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  refundModel.product != null?
                  Text('${refundModel.product.name.toString()}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)):SizedBox(),
                  refundModel.product != null?
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,):SizedBox(),

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
                    Text(refundModel.order != null? getTranslated(refundModel.order.paymentMethod, context):'',
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).hintColor)),
                  ],),
                ],),),
              ],
              ):SizedBox(),
            ),

            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL,Dimensions.PADDING_SIZE_DEFAULT),
              child: isDetails?
              Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text('${getTranslated('reason', context)}: ',
                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).primaryColor)),

                Text( refundModel.refundReason,overflow: TextOverflow.ellipsis,
                    maxLines: isDetails? 50 : 1,
                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
              ],):
              Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text('${getTranslated('reason', context)}: ',
                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).primaryColor)),

                Expanded(
                  child: Text( refundModel.refundReason,overflow: TextOverflow.ellipsis,
                      maxLines: isDetails? 50 : 1,
                      style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                ),
              ],),
            ),

            refundModel.images != null && refundModel.images.length>0 && isDetails?
            RefundAttachmentList(refundModel: refundModel) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
