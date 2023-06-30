import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/body/seller_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/seller_info.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/bank_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  File file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _updateUserAccount() async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _firstNameController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();

    if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.fName == _firstNameController.text
        && Provider.of<ProfileProvider>(context, listen: false).userInfoModel.lName == _lastNameController.text
        && Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone == _phoneController.text && file == null
    && _passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
      showCustomSnackBar(getTranslated('change_something_to_update', context), context);

    }else if (_firstName.isEmpty) {
      showCustomSnackBar(getTranslated('enter_first_name', context), context);

    }else if (_lastName.isEmpty) {
      showCustomSnackBar(getTranslated('enter_first_name', context), context);

    }else if (_phoneNumber.isEmpty) {
      showCustomSnackBar(getTranslated('enter_phone_number', context), context);

    }

    else if((_password.isNotEmpty && _password.length < 6)
        || (_confirmPassword.isNotEmpty && _confirmPassword.length < 6)) {
      showCustomSnackBar(getTranslated('password_be_at_least', context), context);

    }

    else if(_password != _confirmPassword) {
      showCustomSnackBar(getTranslated('password_did_not_match', context), context);

    }

    else {
      SellerModel updateUserInfoModel = Provider.of<ProfileProvider>(context, listen: false).userInfoModel;
      updateUserInfoModel.fName = _firstNameController.text ?? "";
      updateUserInfoModel.lName = _lastNameController.text ?? "";
      updateUserInfoModel.phone = _phoneController.text ?? '';
      String _password = _passwordController.text ?? '';

      SellerModel _bank = Provider.of<BankInfoProvider>(context, listen: false).bankInfo;
      SellerBody _sellerBody = SellerBody(
          sMethod: '_put', fName: _firstNameController.text ?? "", lName: _lastNameController.text ?? "",
        image: updateUserInfoModel.image,
          bankName: _bank.bankName, branch: _bank.branch, holderName: _bank.holderName, accountNo: _bank.accountNo,
      );

      await Provider.of<ProfileProvider>(context, listen: false).updateUserInfo(
        updateUserInfoModel, _sellerBody, file, Provider.of<AuthProvider>(context, listen: false).getUserToken(), _password
      ).then((response) {
        if(response.isSuccess) {
          Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('updated_successfully', context)), backgroundColor: Colors.green));
          setState(() {});
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message), backgroundColor: Colors.red));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(isBackButtonExist: true, title: getTranslated('edit_profile', context),),
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {

          if(_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
            _firstNameController.text = profile.userInfoModel.fName;
            _lastNameController.text = profile.userInfoModel.lName;
            _phoneController.text = profile.userInfoModel.phone;
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: file == null ?
                        CustomImage(width: 100,height: 100,fit: BoxFit.cover,
                            image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/${profile.userInfoModel.image ?? ''}')
                            : Image.file(file, width: 100, height: 100, fit: BoxFit.fill),),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _choose,
                          child: Container(width: 30,height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                              border: Border.all(color: Theme.of(context).cardColor)
                            ),

                            child: IconButton(

                              onPressed: _choose,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.camera_alt_outlined, color: Colors.white, size: Dimensions.ICON_SIZE_DEFAULT,),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    children: [


                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomTextField(
                        border: true,
                        textInputType: TextInputType.name,
                        focusNode: _fNameFocus,
                        nextNode: _lNameFocus,
                        hintText: profile.userInfoModel.fName ?? '',
                        controller: _firstNameController,
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomTextField(
                        border: true,
                        textInputType: TextInputType.name,
                        focusNode: _lNameFocus,
                        nextNode: _phoneFocus,
                        hintText: profile.userInfoModel.lName,
                        controller: _lastNameController,
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Container(
                        child: CustomTextField(
                          idDate: true,
                          hintText: profile.userInfoModel.email ?? "",
                          border: true,

                        ),
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Container(
                        child: CustomTextField(
                          border: true,
                          textInputType: TextInputType.number,
                          focusNode: _phoneFocus,
                          nextNode: _passwordFocus,
                          hintText: profile.userInfoModel.phone ?? "",
                          controller: _phoneController,
                          isPhoneNumber: true,
                        ),
                      ),


                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Container(
                        child: CustomTextField(
                          border: true,
                          hintText: getTranslated('password', context),
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          isPassword: true,
                          nextNode: _confirmPasswordFocus,
                          textInputAction: TextInputAction.next,
                        ),
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Container(
                        child: CustomTextField(
                          border: true,
                          hintText: getTranslated('confirm_password', context),
                          isPassword: true,
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocus,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),







              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return Container(height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125),
                    spreadRadius: 2, blurRadius: 5, offset: Offset.fromDirection(1,2))],
            ),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_MEDIUM),
            width: MediaQuery.of(context).size.width,
            child: !profile.isLoading
                ? CustomButton(
              borderRadius: 10,
                backgroundColor: Theme.of(context).primaryColor, onTap: _updateUserAccount,
                btnTxt: getTranslated('update_profile', context))
                : Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
          );
        }
      ),
    );
  }
}
