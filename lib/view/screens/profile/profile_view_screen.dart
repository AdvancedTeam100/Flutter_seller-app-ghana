import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/profile/profile_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/profile/widget/theme_changer_widget.dart';



class ProfileScreenView extends StatefulWidget {
  @override
  _ProfileScreenViewState createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {



  @override
  void initState() {
    super.initState();
    if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel == null) {
      Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isBackButtonExist: true,title: getTranslated('my_profile', context)),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {


          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_MEDIUM, left: Dimensions.PADDING_SIZE_EXTRA_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Container(height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color:ColorResources.getPrimary(context),
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)
                        ),child: Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL, 0, Dimensions.PADDING_SIZE_SMALL, 0),
                              child: Container(
                                width: 60,height: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  border: Border.all(color: Colors.white, width: 3),
                                  shape: BoxShape.circle,),
                                child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(50)),
                                  child: CustomImage(width: 60, height: 60,
                                    image: '${Provider.of<SplashProvider>(context, listen: false).
                                  baseUrls.sellerImageUrl}/${profile.userInfoModel.image}',fit: BoxFit.cover,),

                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_SMALL, 0, Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_SMALL),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${profile.userInfoModel.fName} ${profile.userInfoModel.lName ?? ''}',
                                    maxLines: 2,textAlign: TextAlign.center,
                                    style: robotoBold.copyWith(color:  ColorResources.getProfileTextColor(context),
                                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                  Text('${profile.userInfoModel.phone}',
                                    maxLines: 2,textAlign: TextAlign.center,
                                    style: titilliumRegular.copyWith(color:  ColorResources.getProfileTextColor(context),
                                        fontSize: Dimensions.FONT_SIZE_SMALL),),
                                ],
                              ),
                            ),
                          ],),
                        ),),
                    ),



                    Container(height: 135,
                      width: MediaQuery.of(context).size.width/1.3,
                      decoration: BoxDecoration(color: Theme.of(context).cardColor.withOpacity(.10),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0 : MediaQuery.of(context).size.width),
                              bottomRight: Radius.circular(Provider.of<LocalizationProvider>(context, listen: false).isLtr?MediaQuery.of(context).size.width : 0))),),

                    Align(alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.topRight: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen())),
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                            child: SizedBox(width: Dimensions.ICON_SIZE_LARGE,
                                child: Image.asset(Images.edit_profile_icon)),
                          ),
                        ))

                  ],),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB( Dimensions.PADDING_SIZE_MEDIUM,
                       Dimensions.PADDING_SEVEN, Dimensions.PADDING_SIZE_MEDIUM, Dimensions.PADDING_SIZE_MEDIUM),
                  child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [

                    Expanded(child: InfoItem(icon: Images.product_icon, title: 'products',amount: profile.userInfoModel.productCount.toString())),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                    Expanded(child: InfoItem(icon: Images.order, title: 'orders',amount: profile.userInfoModel.ordersCount.toString())),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                    Expanded(child: InfoItem(icon: Images.total_earn_icon, title: 'withdrawable_balance',amount: profile.userInfoModel.wallet.totalEarning.toString(), isMoney: true)),


                  ],),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_MEDIUM),
                  child: ThemeChanger(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT,bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated('app_version', context)),
                      Padding(
                        padding: const EdgeInsets.only(left: Dimensions.FONT_SIZE_EXTRA_SMALL),
                        child: Text(AppConstants.APP_VERSION),
                      ),
                    ],
                  ),
                )


              ],
            ),
          );
        },
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;
  final bool isMoney;
  const InfoItem({Key key, this.icon, this.title, this.amount, this.isMoney = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
        boxShadow: [BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
              spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: Dimensions.ICON_SIZE_EXTRA_LARGE,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.ICON_SIZE_EXTRA_LARGE)
              ),
              child: Image.asset(icon, color: Colors.white)),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: !isMoney? Text(amount,
              style: robotoBold.copyWith(color:  Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_LARGE),):
            Text('${Provider.of<SplashProvider>(context, listen: false).myCurrency.symbol} ${NumberFormat.compact().format(double.parse(amount))}',
              style: titilliumSemiBold.copyWith(color:  Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_LARGE),),
          ),




          Text(getTranslated(title, context),
            textAlign: TextAlign.center,
            style: titilliumRegular.copyWith(color:  Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_DEFAULT),),
        ],),
    );
  }
}
