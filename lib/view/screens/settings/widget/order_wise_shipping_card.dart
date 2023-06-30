import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/shipping_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/order_wise_shipping_add_screen.dart';



class OrderWiseShippingCard extends StatelessWidget {
  final ShippingProvider shipProv;
  final ShippingModel shippingModel;
  final int index;
  const OrderWiseShippingCard({Key key, this.shipProv, this.shippingModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_MEDIUM,0,Dimensions.PADDING_SIZE_MEDIUM,Dimensions.PADDING_SIZE_SMALL,),
      child: Container(padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_SMALL,),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          boxShadow: ThemeShadow.getShadow(context),),
        child: Stack(
          children: [
            Column(children: [
              Row(children: [Expanded(child: Text('${index+1}.  ${shippingModel.title}',
                  maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: robotoMedium.copyWith())),

                FlutterSwitch(value: shippingModel.status == 1?true:false,
                  activeColor: Theme.of(context).primaryColor,
                  width: 48,height: 25,toggleSize: 20,padding: 2,
                  onToggle: (value){
                    shipProv.shippingOnOff(context, shippingModel.id, value?1:0, index);
                  },
                ),
                ],),



             Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
               child: Column(children: [
                 Row(
                 children: [
                   Text('${getTranslated('duration', context)}  :   ', style: robotoRegular,),
                   Text('${shippingModel.duration}days', style: robotoRegular.copyWith()),

                 ],
               ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                 Row(
                 children: [
                   Text('${getTranslated('cost', context)}           :   ', style: robotoRegular,),
                   Text('${PriceConverter.convertPrice(context, shippingModel.cost)}',
                       style: robotoRegular.copyWith()),
                 ],
               ),
             ],),),

            ],
      ),
            Positioned(bottom: 10,right: 5,
              child: Row(children: [

                InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context){
                        return ConfirmationDialog(icon: Images.delete,
                            description: getTranslated('are_you_sure_want_to_delete_this_shipping_method', context),
                            onYesPressed: () {Provider.of<ShippingProvider>(context, listen:false).deleteShipping(context ,shippingModel.id);
                            }

                        );});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: ThemeShadow.getShadow(context),
                        borderRadius: BorderRadius.circular(100)
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Image.asset(Images.delete,  width: Dimensions.ICON_SIZE_MEDIUM),
                        ))),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (_)=>OrderWiseShippingAddScreen(shipping: shippingModel));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: ThemeShadow.getShadow(context),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Image.asset(Images.edit_icon, width: Dimensions.ICON_SIZE_MEDIUM, color: Theme.of(context).primaryColor),
                      )),
                ),



              ],),
            )
          ],
        ),
    ),
    );
  }
}
