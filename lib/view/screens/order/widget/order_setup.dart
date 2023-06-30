import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_drop_down_item.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/delivery_man_assign_widget.dart';



class OrderSetup extends StatefulWidget {
  final String orderType;
  final Order orderModel;
  final bool onlyDigital;
  const OrderSetup({Key key, this.orderType, this.orderModel, this.onlyDigital = false}) : super(key: key);

  @override
  State<OrderSetup> createState() => _OrderSetupState();
}

class _OrderSetupState extends State<OrderSetup> {
  @override
  Widget build(BuildContext context) {
    print('==order status=>${widget.orderModel.orderStatus}');
    bool inHouseShipping = false;
    String shipping = Provider.of<SplashProvider>(context, listen: false).configModel.shippingMethod;
    if(shipping == 'inhouse_shipping' && (widget.orderModel.orderStatus == 'out_for_delivery' || widget.orderModel.orderStatus == 'delivered' || widget.orderModel.orderStatus == 'returned' || widget.orderModel.orderStatus == 'failed' || widget.orderModel.orderStatus == 'cancelled')){
      inHouseShipping = true;
    }else{
      inHouseShipping = false;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: getTranslated('order_setup', context),isBackButtonExist: true),
      body: Column(children: [
        Consumer<OrderProvider>(
            builder: (context, order, _) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,),
                  inHouseShipping?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_EXTRA_SMALL, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
                    child: Container(width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: .5,color: Theme.of(context).hintColor.withOpacity(.125)),
                            color: Theme.of(context).hintColor.withOpacity(.12),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE),
                          child: Text(getTranslated(widget.orderModel.orderStatus, context)),
                        )),
                  ):
                  CustomDropDownItem(
                    title: 'order_status',
                    widget: DropdownButtonFormField<String>(
                      value: widget.orderModel.orderStatus,
                      isExpanded: true,
                      decoration: InputDecoration(border: InputBorder.none),
                      iconSize: 24, elevation: 16, style: robotoRegular,
                      onChanged: (value){
                        print('======Selected type==$value======');
                         order.updateOrderStatus(widget.orderModel.id, value, context);
                      },
                      items: order.orderStatusList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(getTranslated(value, context),
                              style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                        );
                      }).toList(),
                    ),
                  ),

                  CustomDropDownItem(
                    title: 'payment_status',
                    widget: DropdownButtonFormField<String>(
                      value: widget.orderModel.paymentStatus,
                      isExpanded: true,
                      decoration: InputDecoration(border: InputBorder.none),
                      iconSize: 24, elevation: 16, style: robotoRegular,
                      onChanged: (value) {
                        order.setPaymentMethodIndex(value == 'paid' ? 0 : 1);
                        order.updatePaymentStatus(orderId: widget.orderModel.id, status: value ,context: context);
                      },
                      items: <String>['paid', 'unpaid'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(getTranslated(value, context),
                              style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                        );
                      }).toList(),
                    ),
                  ),

                   !widget.onlyDigital?
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                     child: DeliveryManAssignWidget(orderType: widget.orderType,orderModel: widget.orderModel,
                         orderId: widget.orderModel.id),
                   ):SizedBox(),

                ],
              );
            }
        ),
      ],),
    );
  }
}



