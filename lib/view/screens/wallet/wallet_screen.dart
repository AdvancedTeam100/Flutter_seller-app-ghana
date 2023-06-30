import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/transaction_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/transaction/transaction_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/wallet/widget/wallet_card.dart';
import 'package:sixvalley_vendor_app/view/screens/wallet/widget/wallet_transaction_list_view.dart';
import 'package:sixvalley_vendor_app/view/screens/wallet/widget/withdraw_balance_widget.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    Provider.of<TransactionProvider>(context, listen: false).getTransactionList(context,'all','','');
    super.initState();
  }
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: getTranslated('wallet', context)),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<TransactionProvider>(context, listen: false).getTransactionList(context,'all','','');
        },
        backgroundColor: Theme.of(context).primaryColor,


        child: CustomScrollView(
          controller: _scrollController,
          slivers: [

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Column(children: [
                  WithdrawBalanceWidget(),
                  Consumer<ProfileProvider>(
                      builder: (context, seller, child) {
                        return Container(child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Row(children: [
                              Expanded(child: WalletCard(
                                amount: '${PriceConverter.convertPrice(context, seller.userInfoModel.wallet != null ?
                                seller.userInfoModel.wallet.withdrawn : 0)}',

                                title: '${getTranslated('withdrawn', context)}',
                                color: ColorResources.withdrawCardColor(context),)),

                              Expanded(child: WalletCard(
                                amount: '${PriceConverter.convertPrice(context, seller.userInfoModel.wallet != null ?
                                seller.userInfoModel.wallet.pendingWithdraw : 0)}',

                                title: '${getTranslated('pending_withdrawn', context)}',
                                color: ColorResources.pendingCardColor(context),)),

                            ],),
                          ),



                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Row(children: [
                              Expanded(child: WalletCard(
                                amount: '${PriceConverter.convertPrice(context, seller.userInfoModel.wallet != null ?
                                seller.userInfoModel.wallet.commissionGiven : 0)}',

                                title: '${getTranslated('commission_given', context)}',
                                color: ColorResources.commissionCardColor(context),)),

                              Expanded(child: WalletCard(
                                amount: '${PriceConverter.convertPrice(context, seller.userInfoModel.wallet != null ?
                                seller.userInfoModel.wallet.deliveryChargeEarned : 0)}',

                                title: '${getTranslated('delivery_charge_earned', context)}',
                                color: ColorResources.deliveryChargeCardColor(context),)),

                            ],),
                          ),


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Row(children: [
                              Expanded(child: WalletCard(
                                amount: '${PriceConverter.convertPrice(context, seller.userInfoModel.wallet != null ?
                                seller.userInfoModel.wallet.collectedCash : 0)}',

                                title: '${getTranslated('collected_cash', context)}',
                                color: ColorResources.collectedCashCardColor(context),)),

                              Expanded(child: WalletCard(
                                amount: '${PriceConverter.convertPrice(context, seller.userInfoModel.wallet != null ?
                                seller.userInfoModel.wallet.totalTaxCollected : 0)}',

                                title: '${getTranslated('total_collected_tax', context)}',
                                color: ColorResources.collectedTaxCardColor(context),)),

                            ],),
                          ),
                        ],),);
                      }
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_SMALL),
                    child: TitleRow(title: getTranslated('withdraw_history', context),
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionScreen())),),
                  ),

                  Consumer<TransactionProvider>(
                      builder: (context, transactionProvider, child) {
                        return  Container(
                          child: transactionProvider.transactionList !=null ? transactionProvider.transactionList.length > 0 ?
                          WalletTransactionListView(transactionProvider: transactionProvider) : NoDataScreen()
                              : Center(child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                        );
                      }
                  ),

                ],),
              )
            )
          ],


        ),
      ),

    );

  }
}

