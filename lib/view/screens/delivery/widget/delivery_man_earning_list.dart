import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_earning-view_all_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_earning_list_view.dart';


class DeliveryManEarningList extends StatefulWidget {
  final DeliveryMan deliveryMan;
  const DeliveryManEarningList({Key key, this.deliveryMan}) : super(key: key);

  @override
  State<DeliveryManEarningList> createState() => _DeliveryManEarningListState();
}

class _DeliveryManEarningListState extends State<DeliveryManEarningList> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Consumer<DeliveryManProvider>(
        builder: (context, earningProvider,_) {
          String _totalWithDrawn = earningProvider.deliveryManEarning?.deliveryMan?.wallet?.totalWithdraw??'0';
          return Column(
            children: [
              EarningItemCard(amount: earningProvider.deliveryManEarning?.totalEarn, title: 'total_earning',icon: Images.total_earning),
              EarningItemCard(amount: earningProvider.deliveryManEarning?.withdrawableBalance, title: 'withdrawable_balance',icon: Images.withdrawable_balance_icon),
              EarningItemCard(amount: double.parse(_totalWithDrawn), title: 'already_withdrawn',icon: Images.already_withdrawn_icon),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: TitleRow(title: getTranslated('earning_statement', context), onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> DeliveryManEarningViewAllScreen(deliveryMan: widget.deliveryMan)));
                },),
              ),

              DeliverymanEarningListView(deliveryMan: widget.deliveryMan, scrollController: _scrollController,),
            ],
          );
        }
      ),
    );
  }
}


class EarningItemCard extends StatelessWidget {
  final double amount;
  final String title;
  final String icon;
  const EarningItemCard({Key key, this.amount, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_MEDIUM,0, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_SMALL ),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1, spreadRadius: 1, offset: Offset(0,1))]
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(PriceConverter.convertPrice(context, amount), style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_MAX_LARGE),),
              SizedBox(height: Dimensions.PADDING_SIZE_MEDIUM,),
              Text(getTranslated(title, context),
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).hintColor))
            ],),
            Container(width: Dimensions.ICON_SIZE_EXTRA_LARGE,child: Image.asset(icon),),
          ],),),
    );
  }
}
