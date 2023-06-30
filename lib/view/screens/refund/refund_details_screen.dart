import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/change_log_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_details.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';

class RefundDetailsScreen extends StatefulWidget {
  final RefundModel refundModel;
  final int orderDetailsId;
  final String variation;
  const RefundDetailsScreen({Key key, this.refundModel, this.orderDetailsId, this.variation}) : super(key: key);

  @override
  State<RefundDetailsScreen> createState() => _RefundDetailsScreenState();
}

class _RefundDetailsScreenState extends State<RefundDetailsScreen> with TickerProviderStateMixin{
  TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener((){
      print('my index is'+ _tabController.index.toString());
      // switch (_tabController.index){
      //   case 0:
      //     Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(1, isNotify: true);
      //     break;
      //   case 1:
      //     Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(0, isNotify: true);
      //     break;
      //
      // }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('refund_details', context),isBackButtonExist: true,),
        body: Consumer<RefundProvider>(
            builder: (context,refundReq,_) {
              return Column( children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).cardColor,
                    child: TabBar(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      controller: _tabController,
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
                        Tab(text: getTranslated("refund_details", context)),
                        Tab(text: getTranslated("change_log", context)),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Expanded(child: TabBarView(
                  controller: _tabController,
                  children: [
                    RefundDetailScreen(refundModel: widget.refundModel, orderDetailsId: widget.orderDetailsId,variation: widget.variation),
                    ChangeLogWidget(refundReq: refundReq),
                  ],
                )),
              ]);
            }
        )
    );
  }
}
