import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/order/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final Order orderModel;
  final int index;
  OrderWidget({@required this.orderModel, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => OrderDetailsScreen (
                  orderModel: orderModel ,orderId: orderModel.id,orderType: orderModel.orderType,
                  extraDiscount: orderModel.extraDiscount,extraDiscountType: orderModel.extraDiscountType,
                ))),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                  boxShadow: [BoxShadow(
                      color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).primaryColor.withOpacity(0):
                      Theme.of(context).primaryColor.withOpacity(.09),blurRadius: 5, spreadRadius: 1, offset: Offset(1,2))]
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,children: [

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL), topRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                      children: [
                        Container(padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(.05),
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                          ),
                          child: Row(
                            children: [
                              Text('${getTranslated('order_no', context)}# ',
                                style: robotoRegular.copyWith(color: ColorResources.getPrimary(context),fontSize: Dimensions.FONT_SIZE_LARGE),),
                              Text('${orderModel.id} ${orderModel.orderType == 'POS'? '(POS)':''} ',
                                style: robotoMedium.copyWith(color: ColorResources.getTextColor(context),fontSize: Dimensions.FONT_SIZE_LARGE),),
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(PriceConverter.convertPrice(context, orderModel.orderAmount !=null?orderModel.orderAmount:0),
                              style: robotoMedium.copyWith(color: Colors.white),),
                          ),),
                      ],
                    ),
                  ),
                ),

                Container(decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                        bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
                ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_SMALL, 0, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      orderModel.createdAt != null?
                      Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderModel.createdAt)),
                          style: robotoRegular.copyWith(color: Theme.of(context).hintColor)):SizedBox(),


                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Row( mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(height: Dimensions.ICON_SIZE_SMALL, width: Dimensions.ICON_SIZE_SMALL,

                                child: Image.asset(orderModel.orderStatus == 'pending'?
                                    Images.order_pending_icon:
                                orderModel.orderStatus == 'out_for_delivery'?
                                    Images.out_icon:
                                orderModel.orderStatus == 'returned'?
                                    Images.return_icon:
                                orderModel.orderStatus == 'delivered'?
                                    Images.delivered_icon:
                                    Images.confirm_purchase

                                ),),
                              Padding(padding: const EdgeInsets.all(8.0),
                                child: Text(getTranslated(orderModel.orderStatus, context),
                                    style: robotoRegular.copyWith(color: ColorResources.getPrimary(context))),
                              ),


                            ],
                          ),

                          Row(children: [


                            Text(orderModel?.paymentMethod != null?getTranslated(orderModel.paymentMethod??'', context):'',
                                style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).hintColor)),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            Container(height: Dimensions.ICON_SIZE_DEFAULT, width: Dimensions.ICON_SIZE_DEFAULT,

                              child: Image.asset(orderModel.paymentMethod == 'cash_on_delivery'? Images.payment_icon:
                              orderModel.paymentMethod == 'pay_by_wallet'? Images.pay_by_wallet_icon : Images.digital_payment_icon),),

                          ],),

                      ],),
                    ],),
                  ),)
              ],),),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        ],
      ),
    );
  }
}

