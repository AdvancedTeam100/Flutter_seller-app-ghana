
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/delivery_man_details.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/add_new_delivery_man.dart';


class DeliveryManCardWidget extends StatelessWidget {
  final DeliveryMan deliveryMan;
  final bool isDetails;
  const DeliveryManCardWidget({Key key, this.deliveryMan, this.isDetails = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isDetails? EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL):
      const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,0,Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_SMALL),
      child: Slidable(
        key: const ValueKey(0),

        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,
          children:  [
            SlidableAction(
              onPressed: (value){
                Provider.of<DeliveryManProvider>(context, listen: false).deleteDeliveryMan(context, deliveryMan.id);
              },
              backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
              foregroundColor: Theme.of(context).errorColor,
              icon: Icons.delete_forever_rounded,
              label: getTranslated('delete', context),
            ),
            SlidableAction(
              onPressed: (value){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewDeliveryManScreen(deliveryMan: deliveryMan)));
              },
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
              label: getTranslated('edit', context),
            ),
          ],
        ),

        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (value){
                Provider.of<DeliveryManProvider>(context, listen: false).deleteDeliveryMan(context, deliveryMan.id);
              },
              backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
              foregroundColor: Theme.of(context).errorColor,
              icon: Icons.delete_forever_rounded,
              label: getTranslated('delete', context),
            ),
            SlidableAction(
              onPressed: (value){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewDeliveryManScreen(deliveryMan: deliveryMan)));
              },
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
              label: getTranslated('edit', context),
            ),
          ],
        ),

        child: GestureDetector(
          onTap: () {
            if(!isDetails){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DeliveryManDetailsScreen(deliveryMan: deliveryMan)));
            }
          },


          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(isDetails? 0 : Dimensions.PADDING_SIZE_SMALL),
                boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
                Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: Offset(1,2))]


            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: isDetails? EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT):
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Container(decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.10),
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),),
                        width: Dimensions.stock_out_image_size,
                        height: Dimensions.stock_out_image_size,


                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                          child: CustomImage(  height: Dimensions.image_size,width: Dimensions.image_size,
                              image: '${Provider.of<SplashProvider>(context, listen: false).
                              baseUrls.deliveryManImageUrl}/${deliveryMan.image}'),

                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(children: [

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


                        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(deliveryMan.fName + ' ' + deliveryMan.lName ?? '', style: robotoMedium.copyWith(
                                      color: ColorResources.titleColor(context),fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                      maxLines: 1, overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(width: 100)
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Row(children: [
                                Icon(Icons.star_rate_rounded, color: Colors.orange),
                                Text(deliveryMan.rating.isNotEmpty? double.parse(deliveryMan.rating[0].average).toStringAsFixed(1) : '0', style: robotoMedium,),
                              ],),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL, top: Dimensions.PADDING_SIZE_SMALL),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                                ),
                                child: Text('${NumberFormat.compact().format(deliveryMan.orders.isNotEmpty? deliveryMan.orders[0].count : 0)} ${getTranslated('orders', context)}',
                                  style: robotoMedium.copyWith(color: Colors.white),),
                              ),
                            )

                          ],),
                        ),
                      ],),
                    ),
                  ],
                ),
                Align(
                  alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisSize: MainAxisSize.min,children: [
                      deliveryMan.isOnline == 1?
                      Icon(Icons.check_circle, size: Dimensions.ICON_SIZE_DEFAULT, color: Colors.green):
                      Icon(Icons.cancel, size: Dimensions.ICON_SIZE_DEFAULT, color: Theme.of(context).errorColor),
                      SizedBox(width: Dimensions.PADDING_SIZE_VERY_TINY),
                      deliveryMan.isOnline == 1?
                      Text(getTranslated('online', context),style: robotoMedium.copyWith(color: Colors.green),):
                      Text(getTranslated('offline', context),style: robotoMedium.copyWith(color: Theme.of(context).errorColor),)
                    ],),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
