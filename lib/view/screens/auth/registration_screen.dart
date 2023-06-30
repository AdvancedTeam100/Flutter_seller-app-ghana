import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/body/register_model.dart';
import 'package:sixvalley_vendor_app/helper/email_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/widgets/info_field_view.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/widgets/register_successfull_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with TickerProviderStateMixin{
  TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener((){
      print('my index is'+ _tabController.index.toString());
      switch (_tabController.index){
        case 0:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(1, isNotify: true);
          break;
        case 1:
          Provider.of<AuthProvider>(context, listen: false).setIndexForTabBar(0, isNotify: true);
          break;

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: getTranslated('shop_application', context), isBackButtonExist: true),

      body: Consumer<AuthProvider>(
        builder: (authContext,authProvider, _) {
          return Column( children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).hintColor,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 1,
                  unselectedLabelStyle: robotoRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    fontWeight: FontWeight.w400,
                  ),
                  labelStyle: robotoRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: [
                    Tab(text: getTranslated("seller_info", context)),
                    Tab(text: getTranslated("shop_info", context)),
                  ],
                ),
              ),
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                InfoFieldVIew(),
                InfoFieldVIew(isShopInfo: true,),
              ],
            )),
          ]);
        }
      ),

      bottomNavigationBar: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            print('tab index is ====>${_tabController.index}/$selectedIndex');
            return Column(mainAxisSize: MainAxisSize.min,
              children: [
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width,
                  lineHeight: 4.0,
                  percent: authProvider.selectionTabIndex == 1? 0.5 : 0.9,
                  backgroundColor: Theme.of(context).hintColor,
                  progressColor: Theme.of(context).colorScheme.onPrimary,
                ),
                authProvider.isLoading? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ):
                Container(height: 70,
                  padding: EdgeInsets.symmetric(vertical : Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor
                  ),
                  child:(authProvider.selectionTabIndex ==1)?
                  CustomButton(btnTxt: getTranslated('next', context), onTap: (){
                    if(authProvider.firstNameController.text.trim().isEmpty){
                      showCustomSnackBar(getTranslated('first_name_is_required', context), context);
                    }else if(authProvider.lastNameController.text.trim().isEmpty){
                      showCustomSnackBar(getTranslated('last_name_is_required', context), context);
                    }else if(authProvider.emailController.text.trim().isEmpty){
                      showCustomSnackBar(getTranslated('email_is_required', context), context);
                    }
                    else if (EmailChecker.isNotValid(authProvider.emailController.text.trim())) {
                      showCustomSnackBar(getTranslated('email_is_ot_valid', context), context);
                    }else if(authProvider.phoneController.text.trim().isEmpty){
                      showCustomSnackBar(getTranslated('phone_is_required', context), context);
                    }
                    else if(authProvider.phoneController.text.trim().length<8){
                      showCustomSnackBar(getTranslated('phone_number_is_not_valid', context), context);
                    }else if(authProvider.passwordController.text.trim().isEmpty){
                      showCustomSnackBar(getTranslated('password_is_required', context), context);
                    }
                    else if(authProvider.passwordController.text.trim().length<8){
                      showCustomSnackBar(getTranslated('password_minimum_length_is_6', context), context);
                    }
                    else if(authProvider.confirmPasswordController.text.trim().isEmpty){
                      showCustomSnackBar(getTranslated('confirm_password_is_required', context), context);
                    }else if(authProvider.passwordController.text.trim() != authProvider.confirmPasswordController.text.trim()){
                      showCustomSnackBar(getTranslated('password_is_mismatch', context), context);
                    }
                    else if(authProvider.sellerProfileImage == null){
                      showCustomSnackBar(getTranslated('profile_image_is_required', context), context);
                    }
                    else{
                      _tabController.animateTo((_tabController.index + 1) % 2);
                      selectedIndex = _tabController.index + 1;
                      authProvider.setIndexForTabBar(selectedIndex);

                    }
                  },):


                  Row(
                    children: [
                      Container(width: 120,
                        child: CustomButton(btnTxt: getTranslated('back', context),
                          backgroundColor: Theme.of(context).hintColor,
                          isColor: true,
                          onTap: (){
                          _tabController.animateTo((_tabController.index + 1) % 2);
                          selectedIndex = _tabController.index + 1;
                          authProvider.setIndexForTabBar(selectedIndex);
                        },),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                        child: CustomButton(
                          backgroundColor: !authProvider.isTermsAndCondition? Theme.of(context).hintColor: Theme.of(context).primaryColor,
                          btnTxt: getTranslated('submit', context), onTap: !authProvider.isTermsAndCondition? null: (){
                          if(authProvider.firstNameController.text.trim().isEmpty){
                            showCustomSnackBar(getTranslated('first_name_is_required', context), context);
                          }else if(authProvider.lastNameController.text.trim().isEmpty){
                            showCustomSnackBar(getTranslated('last_name_is_required', context), context);
                          }else if(authProvider.emailController.text.trim().isEmpty){
                            showCustomSnackBar(getTranslated('email_is_required', context), context);
                          }
                          else if (EmailChecker.isNotValid(authProvider.emailController.text.trim())) {
                            showCustomSnackBar(getTranslated('email_is_ot_valid', context), context);
                          }else if(authProvider.phoneController.text.trim().isEmpty){
                            showCustomSnackBar(getTranslated('phone_is_required', context), context);
                          }
                          else if(authProvider.phoneController.text.trim().length<8){
                            showCustomSnackBar(getTranslated('phone_number_is_not_valid', context), context);
                          }else if(authProvider.passwordController.text.trim().isEmpty){
                            showCustomSnackBar(getTranslated('password_is_required', context), context);
                          }
                          else if(authProvider.passwordController.text.trim().length<8){
                            showCustomSnackBar(getTranslated('password_minimum_length_is_6', context), context);
                          }
                          else if(authProvider.confirmPasswordController.text.trim().isEmpty){
                            showCustomSnackBar(getTranslated('confirm_password_is_required', context), context);
                          }else if(authProvider.passwordController.text.trim() != authProvider.confirmPasswordController.text.trim()){
                            showCustomSnackBar(getTranslated('password_is_mismatch', context), context);
                          }
                          else if(authProvider.shopNameController.text.trim().isEmpty){
                          showCustomSnackBar(getTranslated('shop_name_is_required', context), context);
                          }else if(authProvider.shopAddressController.text.trim().isEmpty){
                          showCustomSnackBar(getTranslated('shop_address_is_required', context), context);
                          }else if(authProvider.shopLogo == null){
                          showCustomSnackBar(getTranslated('shop_logo_is_required', context), context);
                          }else if(authProvider.shopBanner == null){
                          showCustomSnackBar(getTranslated('shop_banner_is_required', context), context);
                          }else{

                            RegisterModel registerModel =  RegisterModel(
                                fName: authProvider.firstNameController.text.trim(),
                                lName: authProvider.lastNameController.text.trim(),
                                phone: authProvider.phoneController.text.trim(),
                                email: authProvider.emailController.text.trim(),
                                password: authProvider.passwordController.text.trim(),
                                confirmPassword: authProvider.confirmPasswordController.text.trim(),
                                shopName: authProvider.shopNameController.text.trim(),
                                shopAddress: authProvider.shopAddressController.text.trim()
                            );
                            authProvider.registration(context, registerModel).then((value){
                              if(value.response.statusCode == 200){
                                showCupertinoModalPopup(context: context, builder: (_) => RegisterSuccessfulWidget());

                              }
                            });
                          }


                        },),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}

