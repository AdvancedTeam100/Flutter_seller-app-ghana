import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';
import 'package:sixvalley_vendor_app/view/screens/pos_printer/invoice_print.dart';
import 'widget/invoice_element_view.dart';

class InVoiceScreen extends StatefulWidget {
  final int orderId;
  const InVoiceScreen({Key key, this.orderId}) : super(key: key);

  @override
  State<InVoiceScreen> createState() => _InVoiceScreenState();
}

class _InVoiceScreenState extends State<InVoiceScreen> {
  Future<void> _loadData() async {
    await Provider.of<OrderProvider>(context, listen: false).getInvoiceData(context, widget.orderId);
    Provider.of<ShopProvider>(context, listen: false).getShopInfo(context);
  }
  double totalPayableAmount = 0;
  double couponDiscount = 0;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('invoice', context),),

      body: Consumer<ShopProvider>(
        builder: (context, shopController, _) {

          return SingleChildScrollView(
            child: Consumer<OrderProvider>(
              builder: (context, invoiceProvider, _) {
                if(invoiceProvider.invoice != null &&  invoiceProvider.invoice.orderAmount != null){
                  totalPayableAmount = invoiceProvider.invoice.orderAmount +
                      invoiceProvider.totalTaxAmount - invoiceProvider.discountOnProduct - invoiceProvider.invoice.extraDiscount - invoiceProvider.invoice.discountAmount;
                }
                return Column(children: [


                  Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Expanded(flex: 3,child: SizedBox.shrink()),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Container(width: 80,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                            color: Theme.of(context).primaryColor,

                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => InVoicePrintScreen(shopModel: shopController.shopModel,
                                    invoice : invoiceProvider.invoice,
                                    orderId: widget.orderId,
                                    discountProduct: invoiceProvider.discountOnProduct,
                                    total: totalPayableAmount,
                                  )));

                            },
                            child: Center(child: Row(
                              children: [
                                Container(child: Icon(Icons.event_note_outlined, color: Theme.of(context).cardColor, size: 15,)),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Text(getTranslated('print', context), style: robotoRegular.copyWith(color: Theme.of(context).cardColor),),
                              ],
                            )),
                          ),),
                      ),

                    ],),
                  ),

                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                    Text(shopController.shopModel?.name??'',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY),),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                    Text('${getTranslated('phone', context)} : ${shopController.shopModel?.contact??''}',
                      style: robotoRegular.copyWith(),),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                  ],),


                  Consumer<OrderProvider>(
                    builder: (context, orderController, _) {
                      return orderController.invoice != null && orderController.invoice.details != null &&  orderController.invoice.details.isNotEmpty ?
                        Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(children: [
                          CustomDivider(color: Theme.of(context).hintColor),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('${getTranslated('invoice', context).toUpperCase()} # ${widget.orderId}',
                                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),

                            Text(getTranslated('payment_method', context),
                                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ],),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('${DateConverter.dateTimeStringToMonthAndTime(orderController.invoice.createdAt)}',
                                style: robotoRegular),

                              Text('${getTranslated('paid_by', context)} ${getTranslated(invoiceProvider.invoice.paymentMethod??'cash', context)}',
                                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            )),
                          ],),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                          CustomDivider(color: Theme.of(context).hintColor),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                          InvoiceElementView(serial: getTranslated('sl', context),
                              title: getTranslated('product_info', context),
                              quantity: getTranslated('qty', context),
                              price: getTranslated('price', context), isBold: true),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          Container(
                            child: ListView.builder(
                              itemBuilder: (con, index){

                                return Container(height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      Expanded(flex: 5,
                                        child:  Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                                          Text((index+1).toString()),
                                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                                          orderController.invoice.details[index].variant != null?
                                          Expanded(
                                              child: Text('${orderController.invoice.details[index].productDetails.name} (${orderController.invoice.details[index].variant??''})',
                                                maxLines: 2,overflow: TextOverflow.ellipsis,)):
                                          Expanded(
                                              child: Text('${orderController.invoice.details[index].productDetails.name}',
                                                maxLines: 2,overflow: TextOverflow.ellipsis,))

                                        ],)
                                      ),
                                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                      Expanded(flex: 3,
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Text(orderController.invoice.details[index].qty.toString()),
                                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                                          Text('${PriceConverter.convertPrice(context, orderController.invoice.details[index].price)}'),
                                        ],),
                                      ),
                                    ],)
                                  ),
                                );
                              },
                              itemCount: orderController.invoice.details.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                            child: CustomDivider(color: Theme.of(context).hintColor),
                          ),


                          Container(child: Column(children: [

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('subtotal', context),style: robotoRegular.copyWith(),),
                              Text(PriceConverter.convertPrice(context, orderController.invoice.orderAmount)),
                            ],),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('product_discount', context),style: robotoRegular.copyWith(),),
                              Text('- ${PriceConverter.convertPrice(context, invoiceProvider.discountOnProduct)}'),
                            ],),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('coupon_discount', context),style: robotoRegular.copyWith(),),
                              Text('- ${PriceConverter.convertPrice(context, orderController.invoice.discountAmount)}'),
                            ],),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('extra_discount', context),style: robotoRegular.copyWith(),),
                              Text(' - ${PriceConverter.convertPrice(context, orderController.invoice.extraDiscount)}'),
                            ],),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Text(getTranslated('tax', context),style: robotoRegular.copyWith(),),
                              Text(' + ${PriceConverter.convertPrice(context, invoiceProvider.totalTaxAmount)}'),
                            ],),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          ],),),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: CustomDivider(color: Theme.of(context).hintColor),
                          ),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text(getTranslated('total', context),style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                            Text(PriceConverter.convertPrice(context, totalPayableAmount),
                                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ],),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),





                          Text('"""${getTranslated('thank_you', context)}"""', style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                            child: CustomDivider(color: Theme.of(context).hintColor),
                          ),



                        ],),
                      ):SizedBox();
                    }
                  ),







                ],);
              }
            ),
          );
        }
      ),
    );
  }
}
