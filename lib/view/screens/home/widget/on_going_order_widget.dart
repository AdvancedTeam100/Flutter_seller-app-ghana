import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/order_type_button_head.dart';

class OngoingOrderWidget extends StatelessWidget {
  final Function callback;
  const OngoingOrderWidget({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return Container(
          padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
                  spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: Dimensions.ICON_SIZE_LARGE,height: Dimensions.ICON_SIZE_LARGE ,
                      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Image.asset(Images.monthly_earning)),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                  Text(getTranslated('business_analytics', context), style: robotoBold.copyWith(
                      color: ColorResources.getTextColor(context),
                      fontSize: Dimensions.FONT_SIZE_DEFAULT),),

                  Expanded(child: SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE,)),
                  Container(
                    height: 50,width: 120,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    ),
                    child: DropdownButton<String>(
                      value: order.analyticsIndex == 0 ? 'overall' : order.analyticsIndex == 1 ?  'today' : 'this_month',
                      items: <String>['overall', 'today', 'this_month' ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(getTranslated(value, context), style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        order.setAnalyticsFilterName(context,value, true);
                       order.setAnalyticsFilterType(value == 'overall' ? 0 : value == 'today'? 1:2, true);

                      },
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),

                ],),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Padding(
              padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_DEFAULT,
                   Dimensions.PADDING_SIZE_EXTRA_SMALL, Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SEVEN),
              child: Text(getTranslated('on_going_orders', context),
                style: robotoBold.copyWith(color: Theme.of(context).primaryColor),),
            ),

            order.orderModel != null ?
            Consumer<OrderProvider>(
              builder: (context, orderProvider, child) => Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,0, Dimensions.PADDING_SIZE_SMALL,Dimensions.FONT_SIZE_SMALL),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .65),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    OrderTypeButtonHead(
                      color: ColorResources.mainCardOneColor(context),
                      text: getTranslated('pending', context), index: 1,
                      subText: getTranslated('orders', context),
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.pending, callback: callback,
                    ),


                    OrderTypeButtonHead(
                      color: ColorResources.mainCardTwoColor(context),
                      text: getTranslated('processing', context), index: 2,
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.processing, callback: callback,
                      subText: getTranslated('orders', context),

                    ),


                    OrderTypeButtonHead(
                      color: ColorResources.mainCardThreeColor(context),
                      text: getTranslated('confirmed', context), index: 7,
                      subText: getTranslated('orders', context),
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.confirmed, callback: callback,
                    ),


                    OrderTypeButtonHead(
                      color: ColorResources.mainCardFourColor(context),
                      text: getTranslated('out_for_delivery', context), index: 8,
                      subText: '',
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.outForDelivery, callback: callback,
                    ),
                  ],
                ),
              ),
            ) : SizedBox(height: 150,
                child: Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)))),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          ],),);
      }
    );
  }
}
