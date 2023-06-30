import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/body/place_order_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/temporary_cart_for_customer.dart' as customer;
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'dart:math';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_header.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/add_new_customer_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/customer_search_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/cart_pricing_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/confirm_purchase_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/coupon_apply_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/extra_discount_and_coupon_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/item_card_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/pos_no_product_widget.dart';


class PosScreen extends StatefulWidget {
  final bool fromMenu;
  const PosScreen({Key key, this.fromMenu = false}) : super(key: key);

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final ScrollController _scrollController = ScrollController();
  double subTotal = 0, productDiscount = 0, total = 0, payable = 0, couponAmount = 0, extraDiscount = 0, productTax = 0, xxDiscount = 0;


  int userId = 0;
  String customerName = '';
  List<String> _paymentVia = ["cash", "card"];


  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getCustomerList(context);
    Provider.of<CartProvider>(context, listen: false).extraDiscountController.text = '0';
    if(Provider.of<CartProvider>(context, listen: false).customerSelectedName == ''){
      Provider.of<CartProvider>(context, listen: false).searchCustomerController.text = 'walking customer';
      Provider.of<CartProvider>(context, listen: false).setCustomerInfo( 0,  'walking customer', 'NULL', false);
    }

  }

  @override
  Widget build(BuildContext context) {


    var rng = Random();
    for (var i = 0; i < 10; i++) {
      print(rng.nextInt(10000));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  CustomAppBar(title: getTranslated('pos', context), isBackButtonExist: true),
      body: Container(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: Consumer<CartProvider>(
                  builder: (context,cartController, _) {

                    productDiscount = 0;
                    total = 0;
                    productTax = 0;
                    subTotal = 0;
                    if(cartController.customerCartList.isNotEmpty){
                      subTotal = cartController.amount;
                      for(int i=0; i< cartController.customerCartList[cartController.customerIndex].cart.length; i++ ){
                        print('dis==> ${cartController.customerCartList[cartController.customerIndex].cart[i].product.discountType}');
                        productDiscount  = cartController.customerCartList[cartController.customerIndex].cart[i].product.discountType == 'flat'?
                        productDiscount + (cartController.customerCartList[cartController.customerIndex].cart[i].product.discount) * (cartController.customerCartList[cartController.customerIndex].cart[i].quantity) :
                        productDiscount + (((cartController.customerCartList[cartController.customerIndex].cart[i].product.discount/100)*
                            cartController.customerCartList[cartController.customerIndex].cart[i].product.unitPrice)) * (cartController.customerCartList[cartController.customerIndex].cart[i].quantity);
                        if(cartController.customerCartList[cartController.customerIndex].cart[i].product.taxModel == "exclude"){
                          productTax = productTax + (((cartController.customerCartList[cartController.customerIndex].cart[i].product.tax/100)*
                              cartController.customerCartList[cartController.customerIndex].cart[i].product.unitPrice)) * (cartController.customerCartList[cartController.customerIndex].cart[i].quantity);

                        }

                      }
                    }


                    if( cartController.customerCartList.isNotEmpty){
                      couponAmount = cartController.customerCartList[cartController.customerIndex].couponAmount?? 0;
                      xxDiscount = cartController.customerCartList[cartController.customerIndex].extraDiscount?? 0;
                    }


                    extraDiscount =  double.parse(PriceConverter.discountCalculationWithOutSymbol(context, subTotal, xxDiscount, cartController.selectedDiscountType));
                    total = subTotal - productDiscount - couponAmount - extraDiscount + productTax;
                    payable = total;

                    return Column(children: [
                      CustomHeader(title: getTranslated('billing_section', context), headerImage: Images.billing_section),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                      Consumer<CartProvider>(
                          builder: (context,customerController,_) {

                            return Container(padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, 0),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    GestureDetector(
                                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CustomerSearchScreen())),
                                        child: Container(width: MediaQuery.of(context).size.width/2,
                                            decoration: BoxDecoration(
                                          border: Border.all(width: .25, color: Theme.of(context).primaryColor.withOpacity(.75)),
                                            color: Theme.of(context).cardColor,
                                            boxShadow: ThemeShadow.getShadow(context),
                                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                                        ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE),
                                              child: Text(customerController.searchCustomerController.text),
                                            ))),


                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                    CustomButton(btnTxt: getTranslated('add_customer', context),
                                      backgroundColor: Theme.of(context).primaryColor,
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => AddNewCustomerScreen()));
                                      },
                                    ),
                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                    CustomButton(btnTxt: getTranslated('new_order', context),
                                      onTap: (){
                                        String customerId = '${customerController.customerId}';
                                        customer.TemporaryCartListModel customerCart = customer.TemporaryCartListModel(
                                          cart: [],
                                          userIndex: customerId != '0' ?  int.parse(customerId) : rng.nextInt(10000),
                                          userId: customerId != '0' ?  int.parse(customerId) : int.parse(customerId),
                                          customerName: customerId == '0'? 'wc-${rng.nextInt(10000)}':'${customerController.customerSelectedName} ${customerController.customerSelectedMobile}',
                                          customerBalance: customerController.customerBalance,
                                        );
                                        Provider.of<CartProvider>(context, listen: false).addToCartListForUser(customerCart, clear: true);

                                      },),

                                  ],)),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Expanded(child: Column(children: [
                                  Text('${getTranslated('current_customer_status', context)} :',
                                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),),

                                  customerController.customerCartList != null?
                                  Container(height: 50,child: Column(children: [

                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Text('${customerController.customerSelectedName??''}',
                                        style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),),
                                    ),



                                    Text('${customerController.customerSelectedMobile != 'NULL'? customerController.customerSelectedMobile??'':''}',
                                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),),
                                  ])):SizedBox(),


                                  SizedBox(height: Dimensions.PADDING_SIZE_CUSTOMER_BOTTOM),
                                  CustomButton(fontColor: ColorResources.getTextColor(context),
                                      btnTxt: getTranslated('clear_all_cart', context),
                                      backgroundColor: Theme.of(context).hintColor.withOpacity(.25),
                                      onTap: (){
                                        Provider.of<CartProvider>(context, listen: false).removeAllCartList();
                                      }),
                                ],)),
                              ],),);
                          }
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),


                      Consumer<CartProvider>(
                          builder: (context, customerCartController, _) {
                            return customerCartController.customerCartList.length > 0 ?
                            Padding(
                              padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_DEFAULT,0),
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                    border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_MEDIUM_BORDER)),
                                child: DropdownButton<int>(
                                  value: customerCartController.customerIds[cartController.customerIndex],
                                  items: customerCartController.customerIds.map((int value) {
                                    print('=======------${customerCartController.customerIds}/$value/${customerCartController.customerIndex}');
                                    return DropdownMenuItem<int>(
                                        value: value,
                                        child:  Text(customerCartController.customerCartList[(customerCartController.customerIds.indexOf(value))].customerName??'',
                                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL))
                                    );
                                  }).toList(),
                                  onChanged: (int value) async {
                                    await customerCartController.setCustomerIndex(cartController.customerIds.indexOf(value), true);
                                    customerCartController.setCustomerInfo(customerCartController.customerCartList[customerCartController.customerIndex].userId,
                                        customerCartController.customerCartList[(customerCartController.customerIndex)].customerName, '', true);
                                    customerCartController.getReturnAmount(payable);



                                  },
                                  isExpanded: true, underline: SizedBox(),),),
                            ):SizedBox();
                          }
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                      Container(
                        padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, 0),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.06),
                        ),
                        child: Row(children: [

                          Expanded(
                              flex:6,
                              child: Text(getTranslated('item_info', context))),
                          Expanded(
                              flex:4,
                              child: Text(getTranslated('qty', context))),
                          Expanded(
                              flex:1,
                              child: Text(getTranslated('price', context))),


                        ],),
                      ),
                      cartController.customerCartList.length > 0?
                      Consumer<CartProvider>(builder: (context,custController,_) {
                        return ListView.builder(
                            itemCount: cartController.customerCartList[custController.customerIndex].cart.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (itemContext, index){
                              return ItemCartWidget(cartModel: cartController.customerCartList[custController.customerIndex].cart[index], index:  index);
                            });
                      }) : SizedBox(),


                      (cartController.customerCartList.isNotEmpty  && cartController.customerIndex !=null && cartController.customerCartList[cartController.customerIndex].cart.length > 0) ?
                      Padding(
                        padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_MEDIUM),
                        child: Container(
                          decoration: BoxDecoration(

                              color: Theme.of(context).cardColor,
                              boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
                              Theme.of(context).primaryColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1, offset: Offset(0,0))]
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(Dimensions.FONT_SIZE_DEFAULT,  Dimensions.PADDING_SIZE_EXTRA_SMALL, Dimensions.FONT_SIZE_DEFAULT,Dimensions.FONT_SIZE_DEFAULT,),
                              child: Row(children: [
                                Expanded(child: Text(getTranslated('bill_summery', context),
                                  style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),)),
                                Container(width: 120,height: 40,child: CustomButton(btnTxt: getTranslated('edit_discount', context),
                                  onTap: (){
                                    showAnimatedDialog(context,
                                        ExtraDiscountAndCouponDialog(),
                                        dismissible: false,
                                        isFlip: false);
                                  },)),
                              ],),
                            ),
                            PricingWidget(title: getTranslated('subtotal', context), amount: '${PriceConverter.convertPrice(context, subTotal)}'),
                            PricingWidget(title: getTranslated('product_discount', context), amount: '${PriceConverter.convertPrice(context,productDiscount)}'),
                            PricingWidget(title: getTranslated('coupon_discount', context), amount: '${PriceConverter.convertPrice(context,couponAmount)}',
                              isCoupon: true,onTap: (){
                                showAnimatedDialog(context,
                                    CouponDialog(),
                                    dismissible: false,
                                    isFlip: false);
                              },),
                            PricingWidget(title: getTranslated('extra_discount', context), amount: '${PriceConverter.discountCalculation(context,
                                subTotal,
                                cartController.extraDiscountAmount,
                                cartController.selectedDiscountType)}'),
                            PricingWidget(title: getTranslated('vat', context), amount: '${PriceConverter.convertPrice(context, productTax)}'),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: CustomDivider(height: .4,color: Theme.of(context).hintColor.withOpacity(1),),
                            ),

                            PricingWidget(title: getTranslated('total', context), amount: '${PriceConverter.convertPrice(context, total)}',isTotal: true),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_SMALL,
                                  Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
                              child: Text(getTranslated('paid_by', context), style: robotoRegular.copyWith(),),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                              child: SizedBox(height: 50,child: ListView.builder(
                                  itemCount: _paymentVia.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return Padding(
                                      padding:  EdgeInsets.only(left : Dimensions.PADDING_SIZE_SMALL),
                                      child: GestureDetector(
                                        onTap: (){
                                          cartController.setPaymentTypeIndex(index, true);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          decoration: BoxDecoration(
                                              color: cartController.paymentTypeIndex == index? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                              border: Border.all(width: .5, color: Theme.of(context).hintColor)
                                          ),
                                          child: Center(child: Text(getTranslated(_paymentVia[index], context),
                                            style: robotoRegular.copyWith(color: cartController.paymentTypeIndex == index?
                                            Colors.white :  null, fontSize: cartController.paymentTypeIndex == index? Dimensions.FONT_SIZE_LARGE : Dimensions.FONT_SIZE_DEFAULT),)),
                                        ),
                                      ),
                                    );
                                  }),),
                            ),



                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),



                            Container(
                              padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0,
                                  Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              height: 50,child: Row(children: [
                              Expanded(child: CustomButton(
                                fontColor: ColorResources.getTextColor(context),
                                btnTxt: getTranslated('cancel', context),
                                backgroundColor: Theme.of(context).hintColor.withOpacity(.25),
                                onTap: (){
                                  subTotal = 0; productDiscount = 0; total = 0; payable = 0; couponAmount = 0; extraDiscount = 0; productTax = 0;
                                  cartController.customerCartList[cartController.customerIndex].cart.clear();
                                  cartController.removeAllCart();
                                },)),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                              Expanded(child: CustomButton(btnTxt: getTranslated('place_order', context),
                                  onTap: (){
                                    if(cartController.customerCartList[cartController.customerIndex].cart.isEmpty){
                                      showCustomSnackBar(getTranslated('please_select_at_least_one_product', context), context);
                                    }
                                    else{
                                      showAnimatedDialog(context,
                                          ConfirmPurchaseDialog(
                                              onYesPressed: cartController.isLoading? null : () {
                                                List<Cart> carts = [];
                                                productDiscount = 0;
                                                for (int index = 0; index < cartController.customerCartList[cartController.customerIndex].cart.length; index++) {
                                                  CartModel cart = cartController.customerCartList[cartController.customerIndex].cart[index];
                                                  carts.add(Cart(
                                                    cart.product.id.toString(),
                                                    cart.price.toString(),
                                                    cart.product.discountType == 'flat'?
                                                    productDiscount + cart.product.discount??0 : productDiscount + ((cart.product.discount/100)*cart.product.unitPrice),
                                                    cart.quantity,
                                                    cart.variant,
                                                    cart.variation!=null?
                                                    [cart.variation]:[],
                                                  ));
                                                }

                                                PlaceOrderBody _placeOrderBody = PlaceOrderBody(
                                                  cart: carts,
                                                  couponDiscountAmount: cartController.couponCodeAmount,
                                                  couponCode: cartController.customerCartList[cartController.customerIndex].couponCode,
                                                  couponAmount: cartController.customerCartList[cartController.customerIndex].couponAmount,
                                                  orderAmount: cartController.amount,
                                                  userId: cartController.customerId,
                                                  extraDiscountType: cartController.selectedDiscountType,
                                                  paymentMethod: cartController.paymentTypeIndex ==0 || cartController.paymentTypeIndex == null? 'cash' : 'card',
                                                  extraDiscount: cartController.extraDiscountController.text.trim().isEmpty? 0.0 : double.parse(PriceConverter.discountCalculationWithOutSymbol(context, subTotal, cartController.extraDiscountAmount, cartController.selectedDiscountType)),
                                                );
                                                if(!cartController.singleClick){
                                                  cartController.placeOrder(context,_placeOrderBody).then((value){
                                                    if(value.response.statusCode == 200){
                                                      couponAmount = 0;
                                                      extraDiscount = 0;
                                                    }
                                                  });
                                                }

                                              }
                                          ),
                                          dismissible: false,
                                          isFlip: false);
                                    }
                                  })),

                            ],),),


                            SizedBox(height: Dimensions.PADDING_SIZE_REVENUE_BOTTOM,),
                          ],),),
                      ):PosNoProductWidget(),
                    ],);
                  }
              ) )
            ],
          ),
        ),
      ),
    );
  }
}


