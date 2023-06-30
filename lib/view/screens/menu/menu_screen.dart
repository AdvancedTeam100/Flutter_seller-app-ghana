import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/add_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/inbox_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/coupon/widget/coupon_list_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/nav_bar_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/delivery_man_setup.dart';
import 'package:sixvalley_vendor_app/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/more/html_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_list_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/profile/profile_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/review/product_review_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/setting_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/shop_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/wallet/wallet_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/bank_info_view.dart';

class MenuBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CustomBottomSheet> _activateMenu = [
      CustomBottomSheet(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/'
          '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.image}',isProfile: true, title: getTranslated('profile', context),

          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreenView()))),

      CustomBottomSheet(image: Images.my_shop, title: getTranslated('my_shop', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ShopScreen()))),

      CustomBottomSheet(image: Images.add_product, title: getTranslated('add_product', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> AddProductScreen()))),

      CustomBottomSheet(image: Images.product_icon_pp, title: getTranslated('products', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductListMenuScreen()))),

      CustomBottomSheet(image: Images.review_icon, title: getTranslated('reviews', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductReview()))),

      CustomBottomSheet(image: Images.coupon_icon, title: getTranslated('coupons', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CouponListScreen()))),

      if(Provider.of<SplashProvider>(context, listen: false).configModel.shippingMethod == 'sellerwise_shipping')
      CustomBottomSheet(image: Images.delivery_man_icon, title: getTranslated('deliveryman', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> DeliveryManSetupScreen()))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel.posActive == 1)
      CustomBottomSheet(image: Images.pos, title: getTranslated('pos', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> NavBarScreen()))),


      CustomBottomSheet(image: Images.settings, title: getTranslated('settings', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> SettingsScreen()))),


      CustomBottomSheet(image: Images.wallet, title: getTranslated('wallet', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> WalletScreen()))),


      CustomBottomSheet(image: Images.message, title: getTranslated('message', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> InboxScreen()))),


      CustomBottomSheet(image: Images.bank_info, title: getTranslated('bank_info', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> BankInfoView()))),


      CustomBottomSheet(image: Images.terms_and_condition, title: getTranslated('terms_and_condition', context),

          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
              title: getTranslated('terms_and_condition', context),
              url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions)))),



      CustomBottomSheet(image: Images.about_us, title: getTranslated('about_us', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
            title: getTranslated('about_us', context),
            url: Provider.of<SplashProvider>(context, listen: false).configModel.aboutUs,)))),


      CustomBottomSheet(image: Images.privacy_policy, title: getTranslated('privacy_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
              title: getTranslated('privacy_policy', context),
              url: Provider.of<SplashProvider>(context, listen: false).configModel.privacyPolicy)))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel.refundPolicy.status ==1)
      CustomBottomSheet(image: Images.refund_policy, title: getTranslated('refund_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
              title: getTranslated('refund_policy', context),
              url: Provider.of<SplashProvider>(context, listen: false).configModel.refundPolicy.content)))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel.returnPolicy.status ==1)
      CustomBottomSheet(image: Images.return_policy, title: getTranslated('return_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
            title: getTranslated('return_policy', context),
            url: Provider.of<SplashProvider>(context, listen: false).configModel.returnPolicy.content)))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel.cancellationPolicy.status ==1)
      CustomBottomSheet(image: Images.c_policy, title: getTranslated('cancellation_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
            title: getTranslated('return_policy', context),
            url: Provider.of<SplashProvider>(context, listen: false).configModel.returnPolicy.content)))),


      CustomBottomSheet(image: Images.logOut, title: getTranslated('logout', context),
          onTap: ()=> showCupertinoModalPopup(context: context, builder: (_) => SignOutConfirmationDialog())),

      CustomBottomSheet(image: Images.app_info, title: 'v - ${AppConstants.APP_VERSION}',
          onTap: (){}),
    ];


    return  Container(
      decoration: BoxDecoration(
        color: ColorResources.getHomeBg(context),
        borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(25),
            topRight: Radius.circular(25)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_down_outlined,color: Theme.of(context).hintColor,
              size: Dimensions.ICON_SIZE_LARGE,),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_VERY_TINY),
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: _activateMenu,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
