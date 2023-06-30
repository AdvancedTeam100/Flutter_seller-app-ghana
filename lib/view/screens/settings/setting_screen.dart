import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/langulage/change_language.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/widget/choose_shipping_dialog.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('settings', context),),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [

          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

          TitleButton(
            icon: Images.language,
            title: getTranslated('choose_language', context),
            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChooseLanguageScreen())),
          ),



          Provider.of<SplashProvider>(context, listen: false).configModel.shippingMethod == 'sellerwise_shipping'?
          TitleButton(
            icon: Images.ship,
            title: '${getTranslated('shipping_setting', context)}',
            onTap: () => showAnimatedDialog(context, ChooseShippingDialog()),
          ):SizedBox(),

        ],
      ),
    );
  }

}
class TitleButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  TitleButton({@required this.icon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color:Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
            Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200],
                spreadRadius: 0.5, blurRadius: 0.3)],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_DEFAULT, horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Row(children: [
              Container(width:Dimensions.ICON_SIZE_LARGE, height:Dimensions.ICON_SIZE_LARGE, child: Image.asset(icon)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
              Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,size: Dimensions.ICON_SIZE_SMALL,),
            ],

            ),
          ),
        ),
      ),
    );
  }
}

