import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_field_with_title.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

class CouponDialog extends StatelessWidget {
  const CouponDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
      child: Consumer<CartProvider>(
          builder: (context, cartController, _) {
            return Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              height: 250,child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [

                CustomFieldWithTitle(
                  customTextField: CustomTextField(hintText: getTranslated('coupon_code_hint', context),
                    controller:cartController.couponController,
                    border: true,
                  ),
                  title: getTranslated('coupon_code', context),
                  requiredField: true,
                ),


                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(children: [
                    Expanded(child: CustomButton(btnTxt: getTranslated('cancel', context),
                        backgroundColor: Theme.of(context).hintColor,
                        onTap: ()=> Navigator.pop(context))),
                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                    Expanded(child: CustomButton(btnTxt: getTranslated('apply', context),
                      onTap: (){
                      if(cartController.couponController.text.trim().isNotEmpty){
                        print('${cartController.couponController.text.trim()}/'
                            '${cartController.customerId}/'
                            '${cartController.amount}');
                        cartController.getCouponDiscount(context,
                            cartController.couponController.text.trim(),
                            cartController.customerId,
                            cartController.amount);
                      }
                      Navigator.pop(context);
                    },)),
                  ],),
                )
              ],),);
          }
      ),
    );
  }
}
