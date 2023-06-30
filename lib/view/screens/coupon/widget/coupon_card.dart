

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/coupon_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/coupon_provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/screens/coupon/widget/add_new_coupon_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/coupon/widget/coupon_details_dialog.dart';

class CouponCard extends StatelessWidget {
  final Coupons coupons;
  final int index;
  const CouponCard({Key key, this.coupons, this.index,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     bool adminCoupon = false;
    if(coupons.addedBy == 'admin' && coupons.couponBearer == 'seller' && coupons.sellerId ==0){
    adminCoupon = true;
    }else{
    adminCoupon = false;
    }
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: Slidable(
        key: const ValueKey(0),
        enabled: adminCoupon? false : true,
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,

          children:  [

            SlidableAction(
              onPressed: (value){
               Provider.of<CouponProvider>(context, listen: false).deleteCoupon(context, coupons.id);
              },
              backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
              foregroundColor: Theme.of(context).errorColor,
              icon: Icons.delete_forever_rounded,
              label: getTranslated('delete', context),
            ),

            SlidableAction(
              onPressed: (value){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewCouponScreen(coupons: coupons)));
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
                Provider.of<CouponProvider>(context, listen: false).deleteCoupon(context, coupons.id);
              },
              backgroundColor: Theme.of(context).errorColor.withOpacity(.05),
              foregroundColor: Theme.of(context).errorColor,
              icon: Icons.delete_forever_rounded,
              label: getTranslated('delete', context),
            ),

            SlidableAction(
              onPressed: (value){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNewCouponScreen(coupons: coupons)));
              },
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
              label: getTranslated('edit', context),
            ),
          ],
        ),

        child: Consumer<CouponProvider>(
            builder: (context, couponProvider,_) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      showDialog(context: context, builder: (_){
                        return CouponDetailsDialog(coupons: coupons);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        boxShadow: ThemeShadow.getShadow(context),),

                      child: Container(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(Images.coupon_icon,width: Dimensions.ICON_SIZE_EXTRA_LARGE),
                              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  //color: Theme.of(context).cardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(coupons.title, style: robotoBold.copyWith(color: Theme.of(context).primaryColor,),
                                            overflow: TextOverflow.ellipsis, maxLines: 1),

                                        Text(getTranslated(coupons.couponType, context), style: robotoRegular.copyWith(),),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(coupons.code, style: robotoBold.copyWith(),),
                                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                                Text(DateConverter.isoStringToDateTimeString(coupons.createdAt),
                                                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT))
                                              ],
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(right: Provider.of<LocalizationProvider>(context, listen: false).isLtr?0:null,
                    left: Provider.of<LocalizationProvider>(context, listen: false).isLtr?null:0,
                    child: Align(
                      alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.topLeft: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
                        child: FlutterSwitch(
                          activeColor: adminCoupon? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).primaryColor,
                            width: 40,height: 20,toggleSize: 18,padding: 1,
                            value: coupons.status == 1,
                            onToggle: (value){
                              if(adminCoupon){
                                showCustomSnackBar(getTranslated('coupon_tooltip', context), context);
                              }else{
                                couponProvider.updateCouponStatus(context, coupons.id, value?1:0, index);
                              }

                            }),
                      ),
                    ),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
