
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/transaction_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transactionModel;
  TransactionWidget({@required this.transactionModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,0, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
      child: Column(crossAxisAlignment : CrossAxisAlignment.start,
        children: [

          Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL), topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              color: Theme.of(context).cardColor,
              boxShadow: ThemeShadow.getShadow(context)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              Text('${getTranslated('transaction_id', context)}# ${transactionModel.id}',
                style: titilliumBold.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),),
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  border: Border.all(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
                  color: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? Theme.of(context).primaryColor.withOpacity(0):
                  Theme.of(context).primaryColor.withOpacity(.07),
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
                ),
                child: Text(PriceConverter.convertPrice(context, transactionModel.amount),
                  style: robotoBold.copyWith(
                      color: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.7),
                      fontSize: Dimensions.FONT_SIZE_DEFAULT),),
              ),



            ]),
          ),

         SizedBox(height: Dimensions.PADDING_SIZE_VERY_TINY),

         Container(width: MediaQuery.of(context).size.width,
           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
           decoration: BoxDecoration(
               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL), bottomRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
               color: Theme.of(context).cardColor,
               boxShadow: ThemeShadow.getShadow(context)
           ),
           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(transactionModel.createdAt)),
               style: titilliumRegular.copyWith(color: ColorResources.getHint(context),
                   fontSize: Dimensions.FONT_SIZE_DEFAULT)),
             SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
             Row(
               children: [
                 SizedBox(width: Dimensions.ICON_SIZE_SMALL,
                     child: Image.asset( transactionModel.approved == 1 ? Images.approve_icon:transactionModel.approved == 2? Images.decline_icon: Images.pending_icon)),
                 Padding(
                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                   child: Text(getTranslated(transactionModel.approved == 2 ?
                   'denied' : transactionModel.approved == 1 ? 'approved' : 'pending', context),
                     style: titilliumRegular.copyWith(color: transactionModel.approved == 1 ? Colors.green : transactionModel.approved == 2 ?
                     Colors.red : Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                 ),
               ],
             ),
           ],),)


        ],
      ),
    );
  }
}
