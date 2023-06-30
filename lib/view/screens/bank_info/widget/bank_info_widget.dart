import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class BankInfoWidget extends StatelessWidget {
  final String name;
  final String bank;
  final String branch;
  final String accountNo;
  const BankInfoWidget({Key key, this.name, this.bank, this.branch, this.accountNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Container(width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)
        ),
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(width: MediaQuery.of(context).size.width/3,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.05),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100) )
                  ),

                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(width: MediaQuery.of(context).size.width/4,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.05),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100) )
                  ),

                ),
              ),
            ),
            Column(children: [
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CardItem(title: 'ac_holder',value: name),
                Padding(
                  padding:  EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT, left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: SizedBox(width: 50, child: Image.asset(Images.bankInfo)),
                )
              ],),
              Divider(color: Theme.of(context).cardColor.withOpacity(.5),thickness: 1.5),

              CardItem(title: 'bank', value: bank),
              CardItem(title: 'branch', value: branch),
              CardItem(title: 'account_no' ,value: accountNo),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            ],),
          ],
        ),),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String value;
  const CardItem({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL,
          Dimensions.PADDING_SIZE_DEFAULT, Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        children: [
          Text('${getTranslated(title, context)} : ',
              style: robotoRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?
              Theme.of(context).hintColor: Theme.of(context).cardColor)),
          Text(value, style: robotoMedium.copyWith(color : Provider.of<ThemeProvider>(context, listen: false).darkTheme?
          Theme.of(context).hintColor: Theme.of(context).cardColor)),

        ],
      ),
    );
  }
}