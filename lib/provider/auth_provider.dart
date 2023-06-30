import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixvalley_vendor_app/data/model/body/register_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/error_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/response_model.dart';
import 'package:sixvalley_vendor_app/data/repository/auth_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({@required this.authRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;
  XFile _sellerProfileImage;
  XFile _shopLogo;
  XFile _shopBanner;
  XFile get sellerProfileImage => _sellerProfileImage;
  XFile get shopLogo => _shopLogo;
  XFile get shopBanner => _shopBanner;
  bool _isTermsAndCondition = false;
  bool get isTermsAndCondition => _isTermsAndCondition;
  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;
  int _selectionTabIndex = 1;
  int get selectionTabIndex =>_selectionTabIndex;


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();


  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode shopNameNode = FocusNode();
  FocusNode shopAddressNode = FocusNode();

  Future<ApiResponse> login(BuildContext context, {String emailAddress, String password}) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(emailAddress: emailAddress, password: password);


    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      Map map = apiResponse.response.data;
      String token = map["token"];
      authRepo.saveUserToken(token);

    } else {
      _isLoading = false;
     showCustomSnackBar(getTranslated('invalid_credential_or_account_not_verified_yet', context), context);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response.data["message"]);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    return responseModel;
  }

  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.updateToken();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }


  void updateTermsAndCondition(bool value) {
    _isTermsAndCondition = value;
    notifyListeners();
  }

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }
  void setIndexForTabBar(int index, {bool isNotify = true}){
    _selectionTabIndex = index;
    print('here is your current index =====>$_selectionTabIndex');
    if(isNotify){
      notifyListeners();
    }

  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String _verificationCode = '';
  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;
  bool get isEnableVerificationCode => _isEnableVerificationCode;
  String _verificationMsg = '';
  String get verificationMessage => _verificationMsg;
  String _email = '';
  String _phone = '';
  String get email => _email;
  String get phone => _phone;
  bool _isPhoneNumberVerificationButtonLoading = false;
  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;


  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }



  Future<ResponseModel> verifyOtp(String phone) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.verifyOtp(phone, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response.data["message"]);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(false, errorMessage);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel> resetPassword(String identity, String otp, String password, String confirmPassword) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.resetPassword(identity,otp,password,confirmPassword);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response.data["message"]);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(false ,errorMessage);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }


  void pickImage(bool isProfile, bool shopLogo, bool isRemove) async {
    if(isRemove) {
      _sellerProfileImage = null;
      _shopLogo = null;
      _shopBanner = null;
    }else {
      if (isProfile) {
        _sellerProfileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else if(shopLogo){
        _shopLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
      }else {
        _shopBanner = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
    }

    notifyListeners();

  }


  Future<ApiResponse> registration(BuildContext context,RegisterModel registerModel) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse  response = await authRepo.registration(_sellerProfileImage, _shopLogo, _shopBanner, registerModel);
    if(response.response.statusCode == 200) {
      _isLoading = false;
      firstNameController.clear();
      lastNameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      shopNameController.clear();
      shopAddressController.clear();
      _sellerProfileImage = null;
      _shopLogo = null;
      _shopBanner = null;
      showCustomSnackBar(getTranslated("you_are_successfully_registered", context), context, isError: false);

    }else {
      _isLoading = false;
      Map map = response.response.data;
      String message = map['message'];
      showCustomSnackBar(message, context);
    }
    _isLoading = false;
    notifyListeners();
    return response;

  }

  String _countryDialCode = '+880';
  String get countryDialCode => _countryDialCode;

  void setCountryDialCode (String setValue){
    _countryDialCode = setValue;

  }

}
