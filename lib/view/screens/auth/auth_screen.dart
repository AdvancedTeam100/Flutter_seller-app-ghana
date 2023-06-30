import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/login_screen.dart';



class AuthScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isActiveRememberMe;
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:  EdgeInsets.only(top : MediaQuery.of(context).size.height/12,
                      bottom: 38),
                      child: Column(
                        children: [
                          Hero(
                              tag: 'logo',
                              child: Padding(
                                padding: const EdgeInsets.only(top : Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                child: Image.asset(Images.logo,width: 80),
                              )),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getTranslated('seller', context),
                                  style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY)),
                              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(getTranslated('app', context),
                                  style: robotoMedium.copyWith(color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Text(getTranslated('login', context),
                    style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_OVER_LARGE))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
                  child: Text(getTranslated('manage_your_business_from_app', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).hintColor)),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                SignInWidget()

              ],
            ),
          );
        }
      ),
    );
  }
}



