import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/collected_cash_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';


class DeliveryManCollectedCashCard extends StatelessWidget {
  final CollectedCash collectedCash;
  final int index;
  DeliveryManCollectedCashCard({@required this.collectedCash, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_SMALL),
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
                      text: collectedCash.id.toString(),
                      style: robotoMedium,
                    ),

                  ],
                ),
              ),

              Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.07),
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                child: Text(PriceConverter.convertPrice(context, double.parse(collectedCash.credit)),
                  style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),),)
            ],),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL,left: Dimensions.PADDING_SIZE_SMALL,
                top: Dimensions.PADDING_SIZE_EXTRA_SMALL, bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(collectedCash.createdAt)),
                style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),



        ],),
      ),
    );
  }
}

