import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_withdraw_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_approve_deny_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_card.dart';

class WithdrawDetailsScreen extends StatefulWidget {
  final Withdraws withdraw;
  final int index;
  const WithdrawDetailsScreen({Key key, this.withdraw, this.index}) : super(key: key);

  @override
  State<WithdrawDetailsScreen> createState() => _WithdrawDetailsScreenState();
}

class _WithdrawDetailsScreenState extends State<WithdrawDetailsScreen> {
  @override
  void initState() {
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManWithdrawDetails(context, widget.withdraw.id);
    super.initState();
  }
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: getTranslated('withdraw_details', context),isBackButtonExist: true),
        body: Consumer<DeliveryManProvider>(
          builder: (context, deliveryManProvider, _) {
            return deliveryManProvider.details != null && deliveryManProvider.details.deliveryMen != null?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                  child: WithdrawCardWidget(withdraw: widget.withdraw, isDetails: true),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: Offset(1,2))]


                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                            color: Theme.of(context).cardColor,
                            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1, offset: Offset(0,1))]
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: '${getTranslated('delivery_man_info', context)}', style: robotoRegular),
                              ],
                            ),
                          ),


                        ],),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      InfoItem(icon: Images.person_icon, title: deliveryManProvider.details.deliveryMen.fName + ' ' +deliveryManProvider.details.deliveryMen.fName),
                      InfoItem(icon: Images.call_icon, title: deliveryManProvider.details.deliveryMen.phone),
                      InfoItem(icon: Images.email_icon, title: deliveryManProvider.details.deliveryMen.email),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                    ],),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: Offset(1,2))]


                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                            color: Theme.of(context).cardColor,
                            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1, offset: Offset(0,1))]
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: '${getTranslated('bank_info', context)}', style: robotoRegular),


                              ],
                            ),
                          ),


                        ],),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      InfoItem(icon: Images.person_icon, title: '${getTranslated('account_holder', context)} : ${deliveryManProvider.details.deliveryMen.holderName??getTranslated('no_data_found', context)}'),
                      InfoItem(icon: Images.credit_card, title: '${getTranslated('account_number', context)} ${deliveryManProvider.details.deliveryMen.accountNo??getTranslated('no_data_found', context)}',),
                      InfoItem(icon: Images.bank, title: '${getTranslated('bank_name', context)} : ${deliveryManProvider.details.deliveryMen.bankName??getTranslated('no_data_found', context)}' ),
                      InfoItem(icon: Images.branch_icon, title: '${getTranslated('branch_name', context)} : ${deliveryManProvider.details.deliveryMen.branch??getTranslated('no_data_found', context)}'),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                    ],),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(children: [
                    Expanded(child: CustomButton(
                      btnTxt: getTranslated('deny', context),
                      backgroundColor: Theme.of(context).errorColor.withOpacity(.125),
                      fontColor: Theme.of(context).errorColor,
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ApproveAndDenyWidget(icon: Images.deny_w,
                                note: noteController,
                                title : getTranslated('deny_this_withdraw_request', context),
                                onYesPressed: () {
                              deliveryManProvider.deliveryManWithdrawApprovedDenied(context, widget.withdraw.id, noteController.text.trim(), 2, widget.index);
                            }

                            );
                          },
                        );
                      },
                    )),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(child: CustomButton(
                      btnTxt: getTranslated('approve', context),
                      backgroundColor: Colors.green[700],
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ApproveAndDenyWidget(icon: Images.approve_w,
                                note: noteController,
                                isApprove: true,
                                title : getTranslated('approve_this_withdraw_request', context),
                                onYesPressed: () {
                                  deliveryManProvider.deliveryManWithdrawApprovedDenied(context, widget.withdraw.id, noteController.text.trim(), 1, widget.index);
                                }

                            );
                          },
                        );
                      },
                    )),
                  ],),
                )


              ],
            ):
            CustomLoader()
            ;
          }
        ));
  }
}

class InfoItem extends StatelessWidget {
  final String icon;
  final String title;
  const InfoItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_EYE),
      child: Container(child: Row(children: [
        SizedBox(width: Dimensions.ICON_SIZE_SMALL, child: Image.asset(icon, color: Theme.of(context).primaryColor,)),
        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

        Expanded(
          child: Text(title??'', style: robotoRegular.copyWith(),maxLines: 1,
            overflow: TextOverflow.ellipsis,),
        )
      ],),),
    );
  }
}
