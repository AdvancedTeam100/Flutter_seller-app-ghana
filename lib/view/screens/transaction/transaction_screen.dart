import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/transaction_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/transaction/widget/transaction_widget.dart';

class TransactionScreen extends StatefulWidget {


  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {


  void _loadData(BuildContext context){
    Provider.of<TransactionProvider>(context, listen: false).getTransactionList(context, 'all','','');
    Provider.of<TransactionProvider>(context, listen: false).initMonthTypeList();
    Provider.of<TransactionProvider>(context, listen: false).initYearList();
  }

  double filterHeight = 45;


  TextEditingController searchController = TextEditingController();


  void initState() {
    super.initState();
    _loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('transactions', context), isAction: true),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {

          return Column(children: [
            SizedBox(height: 65,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    TransactionTypeButton(text: 'all', index: 0),
                    TransactionTypeButton(text: 'pending', index: 1),
                    TransactionTypeButton(text: 'approved', index: 2),
                    TransactionTypeButton(text: 'denied', index: 3),
                  ],
                )),

              Expanded(child: transactionProvider.transactionList != null ? transactionProvider.transactionList.length > 0 ?

               ListView.builder(itemCount: transactionProvider.transactionList.length,
                  itemBuilder: (context, index) => TransactionWidget(
                      transactionModel: transactionProvider.transactionList[index])):
               NoDataScreen() : Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
              ),
            ],
          );
        }
      ),
    );
  }
}

class TransactionTypeButton extends StatelessWidget {
  final String text;
  final int index;
  TransactionTypeButton({@required this.text, @required this.index,});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL, vertical: Dimensions.PADDING_SIZE_MEDIUM),
        child: InkWell(
          onTap: (){
            Provider.of<TransactionProvider>(context, listen: false).setIndex(context, index);
          },
          child: Consumer<TransactionProvider>(builder: (context, transactionProvider, child) {
            return Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: transactionProvider.transactionTypeIndex == index ? Theme.of(context).primaryColor : ColorResources.getButtonHintColor(context),
                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_LARGE),
              ),
              child: Text(getTranslated(text, context), style: transactionProvider.transactionTypeIndex == index
                  ? titilliumBold.copyWith(color: transactionProvider.transactionTypeIndex == index
                  ? ColorResources.getWhite(context) : ColorResources.getTextColor(context)):
              robotoRegular.copyWith(color: transactionProvider.transactionTypeIndex == index
                  ? ColorResources.getWhite(context) : ColorResources.getTextColor(context))),
            );
          },
          ),
        ),
      ),
    );
  }
}