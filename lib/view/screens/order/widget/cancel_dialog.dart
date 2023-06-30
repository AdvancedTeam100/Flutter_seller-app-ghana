
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/dashboard_screen.dart';

class CancelDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorResources.getBottomSheetColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        SizedBox(height: 20),
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.error, size: 50),
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Text(getTranslated('are_you_sure', context), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 18), textAlign: TextAlign.center),
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Text(getTranslated('you_want_to_cancel', context), style: titilliumSemiBold.copyWith(color: ColorResources.getGreyBunkerColor(context)), textAlign: TextAlign.center),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

        Row(children: [

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('no', context), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DashboardScreen()), (route) => false);
              },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.getPrimary(context), borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('yes', context), style: titilliumBold.copyWith(color: ColorResources.getBottomSheetColor(context))),
            ),
          )),

        ]),
      ]),
    );
  }
}
