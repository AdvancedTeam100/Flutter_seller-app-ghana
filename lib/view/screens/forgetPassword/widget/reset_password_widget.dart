import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_pass_textfeild.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/auth_screen.dart';
class ResetPasswordWidget extends StatefulWidget {
  final String mobileNumber;
  final String otp;
  const ResetPasswordWidget({Key key,@required this.mobileNumber,@required this.otp}) : super(key: key);

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  FocusNode _newPasswordNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();
  GlobalKey<FormState> _formKeyReset;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }


  void resetPassword() async {
      String _password = _passwordController.text.trim();
      String _confirmPassword = _confirmPasswordController.text.trim();

      if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      }else if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)),
          backgroundColor: Colors.red,
        ));
      } else {
        Provider.of<AuthProvider>(context, listen: false).resetPassword(widget.mobileNumber,widget.otp,
            _password, _confirmPassword).then((value) {
          if(value.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(getTranslated('password_reset_successfully', context)),
                  backgroundColor: Colors.green,)
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => AuthScreen()), (route) => false);
          }else {
            showCustomSnackBar(value.message, context);
          }
        });

      }
    // }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyReset,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: Image.asset(Images.logo_with_app_name, height: 150, width: 200),
            ),

            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: Text(getTranslated('password_reset', context), style: robotoBold),
            ),
            // for new password
            Container(
                margin:
                EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                    bottom: Dimensions.PADDING_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('new_password', context),
                  focusNode: _newPasswordNode,
                  nextNode: _confirmPasswordNode,
                  controller: _passwordController,
                )),

            // for confirm Password
            Container(
                margin:
                EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                    bottom: Dimensions.PADDING_SIZE_LARGE),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('confirm_password', context),
                  textInputAction: TextInputAction.done,
                  focusNode: _confirmPasswordNode,
                  controller: _confirmPasswordController,
                )),


            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
              child: Provider.of<AuthProvider>(context).isLoading
                  ? Center(child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ) : CustomButton(onTap: resetPassword, btnTxt: getTranslated('reset_password', context)),
            ),


          ],
        ),
      ),
    );
  }
}
