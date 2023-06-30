import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class PosNoProductWidget extends StatelessWidget {
  const PosNoProductWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top :60),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.pos_placeholder, width: 50, height: 50),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                getTranslated('scan_item_or_add_from_item', context),
                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor),
                  textAlign: TextAlign.center,
                ),
              ),

            ]),
      ),
    );
  }
}
