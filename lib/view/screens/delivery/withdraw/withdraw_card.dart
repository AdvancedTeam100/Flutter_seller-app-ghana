
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_withdraw_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_details_screen.dart';

class WithdrawCardWidget extends StatelessWidget {
  final Withdraws withdraw;
  final int index;
  final bool isDetails;
  const WithdrawCardWidget({Key key, this.withdraw, this.index, this.isDetails = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!isDetails){
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => WithdrawDetailsScreen (withdraw: withdraw, index: index,)));
        }
      },

      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_EXTRA_SMALL,0,Dimensions.PADDING_SIZE_EXTRA_SMALL,Dimensions.PADDING_SIZE_SMALL),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: Offset(1,2))]


          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

            Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                color: Theme.of(context).cardColor,
                boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.07), blurRadius: 1, spreadRadius: 1, offset: Offset(0,1))]
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '${getTranslated('xid', context)}# ', style: robotoRegular),
                      TextSpan(
                        text: withdraw.id.toString(),
                        style: robotoMedium,
                      ),

                    ],
                  ),
                ),

                Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.07),
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                  child: Text(PriceConverter.convertPrice(context, withdraw.amount),
                    style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),),)
              ],),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Padding(
              padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL,left: Dimensions.PADDING_SIZE_SMALL,
                  top: Dimensions.PADDING_SIZE_EXTRA_SMALL, bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(withdraw.createdAt)),
                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


            Padding(
              padding: isDetails? EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 0, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_DEFAULT):
              const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
              child: Row( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  withdraw.approved ==1 ?
                  Icon(Icons.check_circle, size: Dimensions.ICON_SIZE_SMALL,color: Colors.green):
                  withdraw.approved ==2 ?
                  Icon(Icons.cancel, size: Dimensions.ICON_SIZE_SMALL, color: Colors.red):
                  Icon(Icons.watch_later, size: Dimensions.ICON_SIZE_SMALL, color: Theme.of(context).primaryColor),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Text(withdraw.approved ==1 ?
                    getTranslated('approved', context) :
                    withdraw.approved ==2 ?
                    getTranslated('denied', context):
                    getTranslated('pending', context),
                        style: robotoRegular.copyWith(color:
                        withdraw.approved ==1 ?
                        Colors.green:
                        withdraw.approved ==2 ?
                        Colors.red:
                        Theme.of(context).primaryColor
                        )
                    ),
                  ),


                ],
              ),
            ),

            withdraw.transactionNote != null?
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL,
                  Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
              child: Text('${getTranslated('note', context)} : ${withdraw.transactionNote}',
                maxLines: isDetails ? 50 : 1,
                overflow: TextOverflow.ellipsis,
                style: robotoRegular.copyWith(color: ColorResources.getTextColor(context).withOpacity(.9)),),
            ): SizedBox()

          ],),
        ),
      ),
    );
  }
}

