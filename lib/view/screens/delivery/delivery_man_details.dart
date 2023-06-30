
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/collect_cash_from_delivery_man_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_earning_list.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_order_history.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/delivery_man_review_list.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/widget/overview_widget.dart';




class DeliveryManDetailsScreen extends StatefulWidget {
  final DeliveryMan deliveryMan;
  const DeliveryManDetailsScreen({Key key, this.deliveryMan}) : super(key: key);
  @override
  State<DeliveryManDetailsScreen> createState() => _DeliveryManDetailsScreenState();
}

class _DeliveryManDetailsScreenState extends State<DeliveryManDetailsScreen> with TickerProviderStateMixin{
  TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManDetails(context, widget.deliveryMan.id);
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManOrderListHistory(context, 1, widget.deliveryMan.id);
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManEarningListHistory(context, 1, widget.deliveryMan.id);
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManReviewList(context, 1, widget.deliveryMan.id);
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryCollectedCashList(context,  widget.deliveryMan.id, 1);

    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);

    _tabController?.addListener((){
      print('my index is'+ _tabController.index.toString());
      switch (_tabController.index){
        case 0:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(0, isNotify: true);
          break;
        case 1:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(1, isNotify: true);
          break;
        case 2:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(2, isNotify: true);
          break;
        case 3:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(3, isNotify: true);
          break;
        case 4:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(4, isNotify: true);
          break;

      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: getTranslated('delivery_man_details', context), isBackButtonExist: true, isAction: true,isSwitch: true,
        switchAction: (value){
          if(value){
            Provider.of<DeliveryManProvider>(context, listen: false).deliveryManStatusOnOff(context, widget.deliveryMan.id, 1);
          }else{
            Provider.of<DeliveryManProvider>(context, listen: false).deliveryManStatusOnOff(context, widget.deliveryMan.id, 0);
          }
        },
      ),

      body: Consumer<AuthProvider>(
          builder: (authContext,authProvider, _) {
            return Column( children: [
              Center(
                child: Container(

                  color: Theme.of(context).cardColor,
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).hintColor,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 1,
                    unselectedLabelStyle: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: [
                      Tab(text: getTranslated("overview", context)),
                      Tab(text: getTranslated("order_history", context)),
                      Tab(text: getTranslated("earnings", context)),
                      Tab(text: getTranslated("reviews", context)),
                      Tab(text: getTranslated("collected_cash", context)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
              Expanded(child: TabBarView(
                controller: _tabController,
                children: [
                  DeliveryManOverViewScreen(deliveryMan: widget.deliveryMan),
                  DeliveryManOrderListScreen(deliveryMan: widget.deliveryMan),
                  DeliveryManEarningList(deliveryMan: widget.deliveryMan),
                  DeliveryManReviewList(deliveryMan: widget.deliveryMan),
                  CollectedCashFromDeliveryMan(deliveryMan: widget.deliveryMan),
                ],
              )),
            ]);
          }
      ),

    );
  }
}
