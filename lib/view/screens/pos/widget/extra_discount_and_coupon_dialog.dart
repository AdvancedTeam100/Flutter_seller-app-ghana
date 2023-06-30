import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_field_with_title.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';


class ExtraDiscountAndCouponDialog extends StatelessWidget {
  const ExtraDiscountAndCouponDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
      child: Consumer<CartProvider>(
        builder: (context, cartController, _) {
          return Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.start,children: [



              Consumer<CartProvider>(
              builder: (context,cartController,_) {
                return Container(padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0, Dimensions.PADDING_SIZE_DEFAULT, 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(getTranslated('discount_type', context),
                      style: robotoRegular.copyWith(),),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      ),
                      child: DropdownButton<String>(
                        value: cartController.discountTypeIndex == 0 ?'amount'  :  'percent',
                        items: <String>['amount','percent'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(getTranslated(value, context)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          cartController.setSelectedDiscountType(value);
                          cartController.setDiscountTypeIndex(value == 'amount' ? 0 : 1, true);

                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                  ]),
                );
              }
            ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              CustomFieldWithTitle(
              customTextField: CustomTextField(hintText: getTranslated('discount_hint', context),
                controller: cartController.extraDiscountController,
                textInputType: TextInputType.number,
                border: true,
                maxSize: cartController.discountTypeIndex == 1? 2 : null,

              ),
              title: cartController.discountTypeIndex == 1?
              getTranslated('discount_percentage', context):
                getTranslated('discount_amount', context),
              requiredField: true,
            ),

              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(children: [
                  Expanded(child: CustomButton(btnTxt: getTranslated('cancel', context),
                      backgroundColor: Theme.of(context).hintColor,
                      onTap: ()=>Navigator.pop(context))),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Expanded(child: CustomButton(btnTxt: getTranslated('apply', context),
                  onTap: (){
                    cartController.applyCouponCodeAndExtraDiscount(context);
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
