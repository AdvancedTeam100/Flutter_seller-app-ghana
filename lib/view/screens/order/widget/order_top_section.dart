import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/show_on_map_dialog.dart';


class OrderTopSection extends StatelessWidget {
  final Order orderModel;
  final OrderProvider order;
  final String orderType;
  final bool onlyDigital;
  const OrderTopSection({Key key, this.orderModel, this.order, this.orderType, this.onlyDigital = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_MEDIUM),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)
      ),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [



        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${getTranslated('order_no', context)}#${orderModel.id}',
                style: titilliumSemiBold.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.FONT_SIZE_LARGE),),

              Padding(
                padding: const EdgeInsets.only(left: 2,top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderModel.createdAt)),
                    style: robotoRegular.copyWith(color: ColorResources.getHint(context),
                        fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
            ],
          ),

          orderType != 'POS' || !onlyDigital?
          GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (_){
                return ShowOnMapDialog();
              });
            },
            child: Row(
              children: [
                Text('${getTranslated('show_on_map', context)}',
                    style: robotoRegular.copyWith()),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Container(decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Image.asset(Images.show_on_map, width: Dimensions.ICON_SIZE_DEFAULT),
                  ),)

              ],
            ),
          ):SizedBox(),
        ]),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Divider(),
        ),


        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: Image.asset(Images.payment_icon,width: Dimensions.ICON_SIZE_SMALL, ),
              ),
              Text(getTranslated(orderModel.paymentMethod, context),
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
            ],
          ),

          Row(children: [
            CircleAvatar(radius: 6, backgroundColor:order.paymentStatus =='paid'
                ? Colors.green: Theme.of(context).errorColor),


            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(getTranslated(order.paymentStatus, context),
                style: robotoRegular.copyWith(color: order.paymentStatus =='paid'
                    ? Colors.green: Theme.of(context).errorColor)),
          ],)
        ],),

        Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: Image.asset(Images.order_status_icon, width: Dimensions.ICON_SIZE_SMALL ),
              ),
              Text(getTranslated('${orderModel.orderStatus}', context),
                  style: titilliumRegular.copyWith(color: ColorResources.mainCardThreeColor(context))),
            ],
          ),
        ),




      ]),
    );
  }
}
