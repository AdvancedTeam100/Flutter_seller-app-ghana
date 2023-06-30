
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/bank_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/bank_editing_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/widget/bank_info_widget.dart';

class BankInfoView extends StatelessWidget {
  const BankInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:getTranslated('bank_info', context), isBackButtonExist: true,),
        body: Consumer<BankInfoProvider>(
          builder: (context, bankProvider, child) {
            String name = bankProvider.bankInfo.holderName?? '';
            String bank = bankProvider.bankInfo.bankName?? '';
            String branch = bankProvider.bankInfo.branch?? '';
            String accountNo = bankProvider.bankInfo.accountNo?? '';
            return Column(
              children: [
                GestureDetector(
                  onTap: ()=>Navigator.push(context,
                      MaterialPageRoute(builder: (_) => BankEditingScreen(sellerModel: bankProvider.bankInfo))),
                  child: Padding(
                    padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(getTranslated('edit_info', context), style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?
                          Theme.of(context).hintColor: Theme.of(context).primaryColor)),
                      Icon(Icons.edit, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme?
                      Theme.of(context).hintColor: Theme.of(context).primaryColor)
                    ],),
                  ),
                ),
                BankInfoWidget(name: name,bank: bank,branch: branch,accountNo: accountNo,),

              ],
            );
          }
        ));
  }
}


