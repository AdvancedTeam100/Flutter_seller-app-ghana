import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/bank_info_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/transaction_chart.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
              spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
      ),
      child: Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Consumer<BankInfoProvider>(builder: (context, bankInfo, child) {


          return (bankInfo.userCommissions!=null && bankInfo.userEarnings != null)?
          TransactionChart():SizedBox();
        }),
      ),
    );
  }
}
