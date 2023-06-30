import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/delivery_man_details.dart';

class TopDeliveryManWidget extends StatelessWidget {
  final DeliveryMan deliveryMan;
  const TopDeliveryManWidget({Key key, this.deliveryMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = Provider.of<SplashProvider>(context, listen: false).baseUrls.deliveryManImageUrl;
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => DeliveryManDetailsScreen(deliveryMan: deliveryMan))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,0,Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?Theme.of(context).primaryColor.withOpacity(0):
                  Theme.of(context).primaryColor.withOpacity(.125),
                      blurRadius: 1,spreadRadius: 1,offset: Offset(0,1))]


              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: Container(decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.1), width: .5)
                  ),
                    width: Provider.of<LocalizationProvider>(context, listen: false).isLtr?  75: 72,
                    height: Provider.of<LocalizationProvider>(context, listen: false).isLtr?  75: 72,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomImage(image: '$baseUrl/${deliveryMan.image}',
                        height: Dimensions.image_size,width: Dimensions.image_size,)


                    ),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: Text(deliveryMan.fName+' '+deliveryMan.lName ?? '',textAlign: TextAlign.center,
                          style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(height: Dimensions.PADDING_SEVEN),




                  ],),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          bottomRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
                  ),
                  child: Column(
                    children: [
                      Text('${NumberFormat.compact().format(deliveryMan.orders.isNotEmpty?deliveryMan.orders[0].count : 0)}',
                        style: robotoMedium.copyWith(color: Colors.white),),


                      Text('${getTranslated('order_delivered', context)}',
                        style: robotoRegular.copyWith(color: Colors.white),),
                    ],
                  ),
                )

              ],),
            ),


          ],
        ),
      ),
    );
  }
}
