import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderChangeLogWidget extends StatelessWidget {
  final int orderId;
  const OrderChangeLogWidget({Key key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManOrderHistoryLogList(context, orderId);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL))),
      child: Consumer<DeliveryManProvider>(
        builder: (context, changelog,_) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_SMALL)),
              boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
                  spreadRadius: 0.5, blurRadius: 0.3)],),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                Text('${getTranslated('history_of_order_no', context)} : $orderId',
                    style: titilliumBold.copyWith(color: ColorResources.getTextColor(context))),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: changelog.changeLogList.length,
                      itemBuilder: (context,index) {

                        return Row(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(flex: 2, child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center, children: [
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_LARGE),
                                    color: Theme.of(context).primaryColor,),
                                  child: Icon(Icons.info_outline,size: Dimensions.ICON_SIZE_DEFAULT,
                                    color: Theme.of(context).cardColor,),
                                ),

                                index == changelog.changeLogList.length-1? SizedBox():
                                Container(height : 60,width: 2, color: Theme.of(context).primaryColor,),

                              ],)),


                            Expanded(flex:6,
                              child: Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                  right: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                  Text(getTranslated(changelog.changeLogList[index].status, context),
                                      style: robotoMedium.copyWith(color: ColorResources.getTextColor(context))),



                                  Text('${changelog.changeLogList[index].userType ?? ''}',
                                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

                                  Text('${DateConverter.isoStringToDateTimeString(changelog.changeLogList[index].createdAt)}',
                                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

                                ]),
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ],
              ),
            ),
          );
        }
      ),
    );
  }
}
