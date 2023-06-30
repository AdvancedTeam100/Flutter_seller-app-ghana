import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/coupon_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/coupon_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_date_picker.dart';
import 'package:sixvalley_vendor_app/view/base/custom_drop_down_item.dart';
import 'package:sixvalley_vendor_app/view/base/custom_field_with_title.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/customer_search_screen.dart';

class AddNewCouponScreen extends StatefulWidget {
  final Coupons coupons;
  const AddNewCouponScreen({Key key, this.coupons}) : super(key: key);

  @override
  State<AddNewCouponScreen> createState() => _AddNewCouponScreenState();
}

class _AddNewCouponScreenState extends State<AddNewCouponScreen> {

  TextEditingController couponTitleController = TextEditingController();
  TextEditingController limitController = TextEditingController();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController minimumPurchaseController = TextEditingController();

  bool update = false;

  @override
  void initState() {
    update = widget.coupons != null? true: false;
    if(update){
      couponTitleController.text = widget.coupons.title;
      couponCodeController.text = widget.coupons.code;
      discountAmountController.text = widget.coupons.discount.toString();
      minimumPurchaseController.text = widget.coupons.minPurchase.toString();
      limitController.text = widget.coupons.limit.toString();
    }
    Provider.of<CouponProvider>(context, listen: false).getCouponCustomerList(context,'');
    if(Provider.of<CouponProvider>(context, listen: false).customerSelectedName == ''){
      Provider.of<CouponProvider>(context, listen: false).searchCustomerController.text = 'All Customer';
      Provider.of<CouponProvider>(context, listen: false).setCustomerInfo( 0,  'All Customer', false);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupon_setup', context),),
      body: Consumer<CouponProvider>(
        builder: (context, coupon,_) {
          return SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
              CustomDropDownItem(
                title: 'coupon_type',
                widget: DropdownButtonFormField<String>(
                  value: coupon.selectedCouponType,
                  isExpanded: true,
                  decoration: InputDecoration(border: InputBorder.none),
                  iconSize: 24, elevation: 16, style: robotoRegular,
                  onChanged: (value) {
                    coupon.setSelectedCouponType(value);
                  },
                  items: coupon.couponTypeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(getTranslated(value, context),
                          style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                    );
                  }).toList(),
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Text(getTranslated('select_customer', context)),
              ),
              GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CustomerSearchScreen(isCoupon: true,))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Container(width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: .25, color: Theme.of(context).hintColor.withOpacity(.75)),
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Row(
                            children: [
                              Expanded(child: Text(coupon.searchCustomerController.text)),
                              Icon(Icons.arrow_drop_down, color: Theme.of(context).hintColor)
                            ],
                          ),
                        )),
                  )),

              SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,),
              CustomFieldWithTitle(
                isCoupon: true,
                title: getTranslated('coupon_title', context),
               customTextField: CustomTextField(
                 border: true,
                 controller: couponTitleController,
                 hintText: getTranslated('coupon_title_hint', context),
               ),

              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT),
                child: Container(
                  child: Column(children: [
                    Row(
                      children: [
                        Text(getTranslated('coupon_code', context), style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                        Spacer(),
                        InkWell(
                            onTap: (){
                              const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                              Random _rnd = Random();

                              String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
                                  length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
                              var code = getRandomString(10);
                              couponCodeController.text = code.toString();
                            },
                            child: Text(getTranslated('generate_code', context), style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).primaryColor))),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    CustomTextField(
                      border: true,
                      controller: couponCodeController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      isAmount: true,
                      hintText: 'Ex: ze5uzkyu0s',
                    ),
                  ],),),
              ),


              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              CustomFieldWithTitle(
                isCoupon: true,
                title: getTranslated('limit_for_same_user', context),
                customTextField: CustomTextField(
                  border: true,
                  isAmount: true,
                  controller: limitController,
                  hintText: getTranslated('limit_user_hint', context),
                ),

              ),

              coupon.selectedCouponType == 'discount_on_purchase'?
              SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM):SizedBox.shrink(),
              coupon.selectedCouponType == 'discount_on_purchase'?
              CustomDropDownItem(
                title: 'discount_type',
                widget: DropdownButtonFormField<String>(
                  value: coupon.discountTypeName,
                  isExpanded: true,
                  decoration: InputDecoration(border: InputBorder.none),
                  iconSize: 24, elevation: 16, style: robotoRegular,
                  onChanged: (value) {
                    coupon.setSelectedDiscountNameType(value);
                  },
                  items: coupon.discountTypeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(getTranslated(value, context),
                          style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                    );
                  }).toList(),
                ),
              ):SizedBox.shrink(),


              coupon.selectedCouponType == 'discount_on_purchase'?
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL): SizedBox.shrink(),
              coupon.selectedCouponType == 'discount_on_purchase'?
              CustomFieldWithTitle(
                isCoupon: true,
                title: getTranslated('discount_amount', context),
                customTextField: CustomTextField(
                  border: true,
                  isAmount: true,
                  controller: discountAmountController,
                  hintText: getTranslated('discount_amount_hint', context),
                ),

              ):SizedBox.shrink(),

              SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM),
              CustomFieldWithTitle(
                isCoupon: true,
                title: getTranslated('minimum_purchase', context),
                customTextField: CustomTextField(
                  border: true,
                  isAmount: true,
                  textInputAction: TextInputAction.done,
                  controller: minimumPurchaseController,
                  hintText: getTranslated('minimum_purchase_hint', context),
                ),

              ),



              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              Row(children: [
                Expanded(child: CustomDatePicker(
                  title: getTranslated('start_date', context),
                  image: Images.calender_icon,
                  text: coupon.startDate != null ?
                  coupon.dateFormat.format(coupon.startDate).toString() : getTranslated('select_date', context),
                  selectDate: () => coupon.selectDate("start", context),
                )),
                Expanded(child: CustomDatePicker(
                  title: getTranslated('expire_date', context),
                  image: Images.calender_icon,
                  text: coupon.endDate != null ?
                  coupon.dateFormat.format(coupon.endDate).toString() : getTranslated('select_date', context),
                  selectDate: () => coupon.selectDate("end", context),
                )),
              ],),
              SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM),



            ],),
          );
        }
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)
        ),
          child: Consumer<CouponProvider>(
            builder: (context, coupon,_) {
              return Consumer<CartProvider>(
                builder: (context, customer,_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: coupon.isAdd?
                    Container(width: 40,
                        child: CircularProgressIndicator()):
                    CustomButton(btnTxt: getTranslated('submit', context),
                    onTap: (){
                      String couponType = coupon.selectedCouponType;
                      int customerId = coupon.selectedCustomerIdForCoupon;
                      String couponTitle = couponTitleController.text.trim();
                      String couponCode = couponCodeController.text.trim();
                      String limit = limitController.text.trim();
                      String discountType = coupon.discountTypeName;
                      String discountAmount = discountAmountController.text.trim();
                      String minimumPurchase = minimumPurchaseController.text.trim();
                      String startDate = update? widget.coupons.startDate :coupon.dateFormat.format(coupon.startDate).toString();
                      String endDate = update? widget.coupons.expireDate : coupon.dateFormat.format(coupon.endDate).toString();
                      if(couponTitle.isEmpty){
                        showCustomSnackBar(getTranslated('coupon_title_is_required', context), context);
                      }else if(couponCode.isEmpty){
                        showCustomSnackBar(getTranslated('coupon_code_is_required', context), context);
                      }else if(limit.isEmpty){
                        showCustomSnackBar(getTranslated('limit_is_required', context), context);
                      }else if(discountAmount.isEmpty && coupon.selectedCouponType == 'discount_on_purchase'){
                        showCustomSnackBar(getTranslated('amount_is_required', context), context);
                      }else if(minimumPurchase.isEmpty){
                        showCustomSnackBar(getTranslated('minimum_purchase_is_required', context), context);
                      }else if(startDate.isEmpty){
                        showCustomSnackBar(getTranslated('start_date_is_required', context), context);
                      }else if(endDate.isEmpty){
                        showCustomSnackBar(getTranslated('end_date_is_required', context), context);
                      }else{
                        Coupons coupons = Coupons(
                          id: update? widget.coupons.id: null,
                          title: couponTitle,
                          couponType: couponType,
                          customerId: customerId,
                          code: couponCode,
                          limit: int.parse(limit),
                          discountType: discountType,
                          discount: coupon.selectedCouponType == 'discount_on_purchase'?double.parse(discountAmount):0,
                          minPurchase: double.parse(minimumPurchase),
                          startDate: startDate,
                          expireDate: endDate
                        );
                        coupon.addNewCoupon(context, coupons, update);
                      }
                    }),
                  );
                }
              );
            }
          )),
    );
  }
}
