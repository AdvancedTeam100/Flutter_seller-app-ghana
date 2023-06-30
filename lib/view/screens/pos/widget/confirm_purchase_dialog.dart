import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';



class ConfirmPurchaseDialog extends StatelessWidget {
  final Function onYesPressed;
  const ConfirmPurchaseDialog({Key key, @required this.onYesPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
        child: Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        height: 240,
          child: Column(children: [
            Container(width: 70,height: 70,
            child: Image.asset(Images.confirm_purchase),),
            Text(getTranslated('confirm_purchase', context)),
            Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Container(height: 40,
                child: Row(children: [
                  Expanded(child: CustomButton(btnTxt: getTranslated('cancel', context),
                      backgroundColor: Theme.of(context).hintColor,
                      onTap: ()=>Navigator.pop(context))), SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Expanded(child: CustomButton(btnTxt: getTranslated('yes', context),
                    onTap: (){
                    onYesPressed();
                    Navigator.pop(context);
                    },)),
                ],),
              ),
            )
          ],),
        ));
  }
}
