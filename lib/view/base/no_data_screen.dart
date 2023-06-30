import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class NoDataScreen extends StatelessWidget {
  final String title;
  const NoDataScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.no_order_found, width: 100, height: 100),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(title != null? getTranslated(title, context):
              getTranslated('nothing_found', context),
              style: robotoRegular.copyWith(color: Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),
          ),

        ]),
      ),
    );
  }
}
