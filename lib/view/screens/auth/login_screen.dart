import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/email_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/registration_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/forgetPassword/forget_password_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/more/html_view_screen.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text = Provider.of<AuthProvider>(context, listen: false).getUserEmail() ?? null;
    _passwordController.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<AuthProvider>(context, listen: false).isActiveRememberMe;

    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Form(
        key: _formKeyLogin,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE, 
                        bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: CustomTextField(
                      border: true,
                      prefixIconImage: Images.email_icon,
                      hintText: getTranslated('enter_email_address', context),
                      focusNode: _emailFocus,
                      nextNode: _passwordFocus,
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                    )),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



                Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, 
                    right: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_DEFAULT),
                    child: CustomTextField(
                      border: true,
                      isPassword: true,
                      prefixIconImage: Images.lock,
                      hintText: getTranslated('password_hint', context),
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                    )),





                Container(
                  margin: EdgeInsets.only(left: 24, right: Dimensions.PADDING_SIZE_LARGE),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) => InkWell(
                      onTap: () => authProvider.toggleRememberMe(),
                      child: Row(
                        children: [
                          Container(width: Dimensions.ICON_SIZE_DEFAULT, height: Dimensions.ICON_SIZE_DEFAULT,
                            decoration: BoxDecoration(color: authProvider.isActiveRememberMe ? 
                            Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                border: Border.all(color:  authProvider.isActiveRememberMe ?
                                Theme.of(context).primaryColor : Theme.of(context).hintColor.withOpacity(.5)),
                                borderRadius: BorderRadius.circular(3)),
                            child: authProvider.isActiveRememberMe ? 
                            Icon(Icons.done, color: ColorResources.WHITE,
                                size: Dimensions.ICON_SIZE_SMALL) : SizedBox.shrink(),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          

                          Text(getTranslated('remember_me', context),
                            style: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: ColorResources.getHintColor(context)),
                          ),
                          Spacer(),


                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPasswordScreen())),
                            child: Text(getTranslated('forget_password', context),
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                SizedBox(height: Dimensions.PADDING_SIZE_BUTTON),

                
                !authProvider.isLoading ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: CustomButton(
                    borderRadius: 100,
                    backgroundColor: Theme.of(context).primaryColor,
                    btnTxt: getTranslated('login', context),
                    onTap: () async {
                      String _email = _emailController.text.trim();
                      String _password = _passwordController.text.trim();
                      if (_email.isEmpty) {
                        showCustomSnackBar(getTranslated('enter_email_address', context), context);
                      }else if (EmailChecker.isNotValid(_email)) {
                        showCustomSnackBar(getTranslated('enter_valid_email', context), context);
                      }else if (_password.isEmpty) {
                        showCustomSnackBar(getTranslated('enter_password', context), context);
                      }else if (_password.length < 6) {
                        showCustomSnackBar(getTranslated('password_should_be', context), context);
                      }else {authProvider.login(context, emailAddress: _email, password: _password).then((status) async {
                          if (status.response.statusCode == 200) {
                            if (authProvider.isActiveRememberMe) {
                              authProvider.saveUserNumberAndPassword(_email, _password);
                            } else {
                              authProvider.clearUserEmailAndPassword();
                            }
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardScreen()));
                          }
                        });
                      }
                  },
                  ),
                ) :
                Center( child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),

                )),

                Provider.of<SplashProvider>(context, listen: false).configModel.sellerRegistration == "1"?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegistrationScreen()));
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(getTranslated('dont_have_an_account', context),style: robotoRegular,),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Text(getTranslated('registration_here', context),
                            style: robotoTitleRegular.copyWith(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                ): SizedBox(),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_BOTTOM_SPACE),
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(
                          title: getTranslated('terms_and_condition', context),
                          url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions,
                        )));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getTranslated('terms_and_condition', context),
                              style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)),
                        ],
                      )),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
