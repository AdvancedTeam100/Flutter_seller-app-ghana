import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/forgetPassword/widget/code_picker_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/forgetPassword/widget/my_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/forgetPassword/widget/otp_verification_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _numberFocus = FocusNode();
  String _countryDialCode = '880';

  @override
  void initState() {
    _countryDialCode = CountryCode.fromCountryCode(
        Provider.of<SplashProvider>(context, listen: false).configModel.countryCode).dialCode;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: CustomAppBar(isBackButtonExist: true,title: getTranslated('forget_password', context),),


      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 95),

              Image.asset(Images.forget_password_icon, height: 100, width: 100),

              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text('${getTranslated('forget_password', context)}?', style: robotoMedium),
              ),


              Provider.of<SplashProvider>(context,listen: false).configModel.forgetPasswordVerification == "phone"?
              Text(getTranslated('enter_phone_number_for_password_reset', context),
                  style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)):
              Text(getTranslated('enter_email_for_password_reset', context),
                  style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                      fontSize: Dimensions.FONT_SIZE_DEFAULT)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),


              Provider.of<SplashProvider>(context,listen: false).configModel.forgetPasswordVerification == "phone"?
              Row(children: [
                CodePickerWidget(
                  onChanged: (CountryCode countryCode) {
                    _countryDialCode = countryCode.dialCode;
                  },
                  initialSelection: _countryDialCode,
                  favorite: [_countryDialCode],
                  showDropDownButton: true,
                  padding: EdgeInsets.zero,
                  showFlagMain: true,
                  textStyle: TextStyle(color: Theme.of(context).textTheme.headline1.color),
                ),


                Expanded(child: CustomTextField(
                  border: true,
                  hintText: getTranslated('number_hint', context),
                  controller: _numberController,
                  focusNode: _numberFocus,
                  isPhoneNumber: true,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.phone,
                )),
              ]) :

              CustomTextField(
                border: true,
                prefixIconImage: Images.email_icon,
                controller: _controller,
                hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

              Consumer<AuthProvider>(
                builder: (context, authProvider,_) {
                  return !authProvider.isLoading ?
                  CustomButton(
                    borderRadius: 10,
                    btnTxt: Provider.of<SplashProvider>(context,listen: false).configModel.forgetPasswordVerification == "phone"?
                    getTranslated('send_otp', context):getTranslated('send_email', context),
                    onTap: () {
                      String code;
                      if(Provider.of<SplashProvider>(context,listen: false).configModel.forgetPasswordVerification == "phone"){
                        if(_numberController.text.isEmpty) {
                          showCustomSnackBar(getTranslated('PHONE_MUST_BE_REQUIRED', context), context);

                        }else{
                          if(_countryDialCode.contains('+')){
                            code = _countryDialCode.replaceAll('+', '');
                          }

                          Provider.of<AuthProvider>(context, listen: false).
                          forgetPassword(code+_numberController.text.trim()).then((value) {
                            if(value.isSuccess) {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (_) => VerificationScreen(
                                      code+_numberController.text.trim())),
                                      (route) => false);
                            }else {
                              showCustomSnackBar(getTranslated('input_valid_phone_number', context), context);
                            }
                          });
                        }

                      }else{
                        if(_controller.text.isEmpty) {
                          showCustomSnackBar(getTranslated('EMAIL_MUST_BE_REQUIRED', context), context);
                        }
                        else {
                          Provider.of<AuthProvider>(context, listen: false).forgetPassword(_controller.text).then((value) {
                            if(value.isSuccess) {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              _controller.clear();

                              showAnimatedDialog(context, MyDialog(
                                icon: Icons.send,
                                title: getTranslated('sent', context),
                                description: getTranslated('recovery_link_sent', context),
                                rotateAngle: 5.5,
                              ), dismissible: false);
                            }else {
                              showCustomSnackBar(value.message, context);
                            }
                          });
                        }
                      }


                    },
                  ) :
                  Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

