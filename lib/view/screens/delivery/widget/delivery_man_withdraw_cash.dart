import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/delivery_man_collect_cash_widget.dart';




class DeliveryManWithdrawBalanceWidget extends StatelessWidget {
  final DeliveryManProvider deliveryManProvider;
  const DeliveryManWithdrawBalanceWidget({Key key, this.deliveryManProvider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context, listen: false).darkTheme;
    return Container(padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),

      color: Theme.of(context).cardColor,
      alignment: Alignment.center,
      child:Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width/2.5,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
              boxShadow: [BoxShadow(color: Colors.grey[darkMode ? 900 : 200],
                  spreadRadius: 0.5, blurRadius: 0.3)],
            ),

          ),
          Align(alignment: Alignment.centerLeft,
            child: Container(width: MediaQuery.of(context).size.width-70,height: MediaQuery.of(context).size.width/2.5,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(.10),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(MediaQuery.of(context).size.width/2.5))
              ),),
          ),
          Consumer<ProfileProvider>(
              builder: (context, seller, child) {
                return Container(
                  height: MediaQuery.of(context).size.width/2.5,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container (width: Dimensions.ICON_SIZE_LARGE,
                                  height: Dimensions.ICON_SIZE_LARGE,
                                  child: Image.asset(Images.card_white)),
                              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                              Text(PriceConverter.convertPrice(context, deliveryManProvider.deliveryManDetails?.deliveryMan?.wallet != null ?
                              double.parse(deliveryManProvider.deliveryManDetails.deliveryMan.wallet.cashInHand) ?? 0 : 0),
                                  style: robotoBold.copyWith(color: Colors.white,
                                      fontSize: Dimensions.FONT_SIZE_WITHDRAWABLE_AMOUNT)),
                            ],
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                          Text(getTranslated('cash_in_hand', context),
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  color: Colors.white)),

                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                      InkWell(
                        child: Container(height: 40,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                          child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,children: [
                            InkWell(onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context, builder: (_) =>
                                CollectedCashFromDeliveryManDialog(
                                  deliveryManId: deliveryManProvider.deliveryManDetails?.deliveryMan?.id,
                                  totalCashInHand: deliveryManProvider.deliveryManDetails?.deliveryMan?.wallet != null ?
                                double.parse(deliveryManProvider.deliveryManDetails.deliveryMan.wallet.cashInHand) ?? 0 : 0,)),

                              child: Text(getTranslated('collect_cash', context),
                                  style:robotoMedium.copyWith(color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.FONT_SIZE_LARGE)),
                            ),

                          ],),
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
