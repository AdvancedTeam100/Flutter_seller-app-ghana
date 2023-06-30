import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/screens/shipping/widget/drop_down_for_shipping_type.dart';

class ProductWiseShipping extends StatefulWidget {
  const ProductWiseShipping({Key key}) : super(key: key);

  @override
  State<ProductWiseShipping> createState() => _ProductWiseShippingState();
}

class _ProductWiseShippingState extends State<ProductWiseShipping> {

  @override
  void initState() {
    Provider.of<ShippingProvider>(context, listen: false).iniType('product_type');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('shipping_method', context),isBackButtonExist: true,),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
          DropDownForShippingTypeWidget(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top : MediaQuery.of(context).size.height/5),
                  child: SizedBox(width: MediaQuery.of(context).size.width/3,
                      child: Image.asset(Images.product_wise_shipping)),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_BUTTON),
                  child: Text(getTranslated('product_wise_delivery_note', context),style: robotoRegular.copyWith(),textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
          SizedBox()

        ],));
  }
}
