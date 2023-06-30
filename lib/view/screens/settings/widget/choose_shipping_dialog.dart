
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';

class ChooseShippingDialog extends StatefulWidget {

  ChooseShippingDialog({Key key});

  @override
  State<ChooseShippingDialog> createState() => _ChooseShippingDialogState();
}

class _ChooseShippingDialogState extends State<ChooseShippingDialog> {


  @override
  void initState() {
    Provider.of<ShippingProvider>(context,listen: false).getSelectedShippingMethodType(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('========ss=======>${MediaQuery.of(context).size.width}');

    return Dialog(
      backgroundColor: Theme.of(context).highlightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Consumer<ShippingProvider>(
        builder: (cont, shippingProvider, _) {
          return Column(mainAxisSize: MainAxisSize.min, children: [

            Padding(
              padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_EXTRA_LARGE, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
              child: Text(getTranslated('choose_shipping', context), style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(getTranslated('select_shipping_method', context),textAlign: TextAlign.center,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
            ),

            Consumer<SplashProvider>(
              builder: (context, splash, child) {
                List<String> _valueList = [];
                splash.shippingTypeList.forEach((shipping) => _valueList.add(getTranslated(shipping, context)));

                return Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: GridView.builder(
                    itemCount: _valueList.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width < 380? 1/.7 : 1/.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10

                      ),
                      itemBuilder: (context, i){
                    return GestureDetector(
                      onTap: (){
                        shippingProvider.setShippingType(i);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        color:  shippingProvider.shippingIndex ==i? Theme.of(context).primaryColor: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).primaryColor.withOpacity(0):
                        Theme.of(context).hintColor.withOpacity(.25), blurRadius: 5, spreadRadius: 1, offset: Offset(1,2))]
                      ),
                        child: Stack(children: [
                          Center(child: Text('${_valueList[i]}\n ${getTranslated('shipping', context)}',textAlign: TextAlign.center,
                              style: robotoRegular.copyWith(color: shippingProvider.shippingIndex ==i?
                              Colors.white : Theme.of(context).hintColor))),

                          shippingProvider.shippingIndex ==i?
                          Align(
                            alignment : Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(Icons.check_circle, color: Theme.of(context).cardColor),
                              )):SizedBox()

                      ],),),
                    );
                  }),
                );
              },
            ),


            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(children: [
                Expanded(
                  child: CustomButton(fontColor: ColorResources.getTextColor(context),
                      btnTxt: getTranslated('cancel', context),
                  backgroundColor: Theme.of(context).hintColor.withOpacity(.5),
                  onTap: () => Navigator.pop(context)),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                Expanded(
                  child: CustomButton(
                    fontColor: Colors.white,
                      btnTxt: getTranslated('update', context),
                      onTap: (){
                      String type;
                      if(shippingProvider.shippingIndex == 0){
                        type =  'order_wise';
                      }else if(shippingProvider.shippingIndex == 1){
                        type =  'product_wise';
                      }else if(shippingProvider.shippingIndex ==2){
                        type =  'category_wise';
                      }
                      shippingProvider.setShippingMethodType(context,  type).then((value){
                        if(value.response.statusCode == 200){
                          Provider.of<SplashProvider>(context, listen: false).initConfig(context);
                          Navigator.pop(context);
                        }
                      });


                  }),
                ),

              ]),
            ),

          ]);
        }
      ),
    );
  }
}