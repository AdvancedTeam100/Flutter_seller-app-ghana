import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/category_wise_shipping_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

class CategoryWiseShippingCard extends StatelessWidget {
  final ShippingProvider shipProv;
  final Category category;
  final int index;

  const CategoryWiseShippingCard({Key key, this.shipProv, this.category, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      decoration: BoxDecoration(
        color: ColorResources.getBottomSheetColor(context),
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
        boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).primaryColor.withOpacity(0):
        Theme.of(context).primaryColor.withOpacity(.1), spreadRadius: 1, blurRadius: 1, offset: Offset(0,1))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.095),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL), topRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
          ),
          child: Row(
            children: [
              Text('${index + 1}.  ${category!=null? category.name:''??''}', maxLines: 3,overflow: TextOverflow.ellipsis,
                style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
            ],
          ),
        ),

        Row(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(.05),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.ICON_SIZE_MEDIUM),
                      child: Text('${getTranslated('cost_per_product', context)} (${Provider.of<SplashProvider>(context, listen: false).myCurrency.symbol})',
                          style: robotoRegular.copyWith()),
                    ),


                    CustomTextField(
                      border: true,
                      controller: shipProv.shippingCostController[index],
                      focusNode: shipProv.shippingCostNode[index],
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      isAmount: true,
                      // isAmount: true,
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,)
                  ],
                ),
              ),
            ),
          ),


          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
              ),

              child: Column(mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Text('${getTranslated('multiply_with_qty', context)}',
                      style: robotoRegular.copyWith()),
                ),
                    FlutterSwitch(width: 40,height: 20,toggleSize: 16,padding: 2,
                      value:shipProv.isMultiply[index],
                  onToggle: (value){
                    shipProv.toggleMultiply(context,value,index);
                  },
                ),
                    SizedBox(height: 42)
              ]),
            ),
          ),
        ]),



      ]),
    );
  }
}
