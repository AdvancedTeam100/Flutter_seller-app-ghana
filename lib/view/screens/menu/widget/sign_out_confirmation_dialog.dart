
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/auth_screen.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  final bool isDelete;
  const SignOutConfirmationDialog({Key key, this.isDelete = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorResources.getBottomSheetColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [

                SizedBox(height: 30),
                SizedBox(width: 52,height: 52,
                  child: Image.asset(Images.log_out_icon),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_LARGE, 13, Dimensions.PADDING_SIZE_LARGE,0),
                  child: Text(isDelete? getTranslated('want_to_delete_account', context):
                  getTranslated('want_to_sign_out', context),
                      style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).hintColor),
                      textAlign: TextAlign.center),
                ),

                Container(height: 80,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,24,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_DEFAULT),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(children: [
                        Expanded(
                          child: CustomButton(borderRadius: 15,
                            btnTxt: getTranslated('yes', context),
                            backgroundColor: Theme.of(context).errorColor,
                            fontColor: Colors.white,
                            isColor: true,
                            onTap: ()  {

                              if(isDelete){
                                Provider.of<ProfileProvider>(context, listen: false).deleteCustomerAccount(context).then((condition) {
                                  if(condition.response.statusCode == 200){
                                    Navigator.pop(context);
                                    Provider.of<AuthProvider>(context,listen: false).clearSharedData();
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
                                  }

                                });
                              }
                              else{
                                Provider.of<AuthProvider>(context, listen: false).clearSharedData();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
                                // Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
                                //   Navigator.pop(context);
                                //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
                                // });
                              }

                            },
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Expanded(
                          child: CustomButton(borderRadius: 15,
                            btnTxt: getTranslated('no', context),
                            isColor: true,
                            fontColor: ColorResources.getTextColor(context),
                            backgroundColor: Theme.of(context).hintColor.withOpacity(.25),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),




                      ]),
                    ),
                  ),
                ),
              ]),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Container(width: 18,child: Image.asset(Images.cross, color: ColorResources.getTextColor(context))),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
