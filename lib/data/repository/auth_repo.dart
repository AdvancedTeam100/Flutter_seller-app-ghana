import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/body/register_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> login({String emailAddress, String password}) async {
    try {
      Response response = await dioClient.post(AppConstants.LOGIN_URI,
        data: {"email": emailAddress, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> forgetPassword(String identity) async {
    try {
      Response response = await dioClient.post(AppConstants.FORGET_PASSWORD_URI, data: {"identity": identity});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String identity, String otp ,String password, String confirmPassword) async {
    try {
      Response response = await dioClient.post(
          AppConstants.RESET_PASSWORD_URI, data: {"_method" : "put",
        "identity": identity.trim(), "otp": otp,
        "password": password, "confirm_password":confirmPassword});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyOtp(String identity, String otp) async {
    try {
      Response response = await dioClient.post(
          AppConstants.VERIFY_OTP_URI, data: {"identity": identity.trim(), "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken = await _getDeviceToken();
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String> _getDeviceToken() async {
    String _deviceToken;
    if(Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }else {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return sharedPreferences.remove(AppConstants.TOKEN);
    //return sharedPreferences.clear();
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<ApiResponse> registration(XFile profileImage, XFile shopLogo, XFile shopBanner, RegisterModel registerModel) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.REGISTRATION}'));
    if(profileImage != null) {
      Uint8List _list = await profileImage.readAsBytes();
      var part = http.MultipartFile('image', profileImage.readAsBytes().asStream(), _list.length, filename: basename(profileImage.path));
      request.files.add(part);
    } if(shopLogo != null) {
      Uint8List _list = await shopLogo.readAsBytes();
      var part = http.MultipartFile('logo', shopLogo.readAsBytes().asStream(), _list.length, filename: basename(shopLogo.path));
      request.files.add(part);
    } if(shopBanner != null) {
      Uint8List _list = await shopBanner.readAsBytes();
      var part = http.MultipartFile('banner', shopBanner.readAsBytes().asStream(), _list.length, filename: basename(shopBanner.path));
      request.files.add(part);
    }

    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'f_name': registerModel.fName,
      'l_name': registerModel.lName,
      'phone': registerModel.phone,
      'email': registerModel.email,
      'password': registerModel.password,
      'confirm_password': registerModel.confirmPassword,
      'shop_name': registerModel.shopName,
      'shop_address': registerModel.shopAddress,
    });

    request.fields.addAll(_fields);
    print('=====> ${request.url.path}\n'+request.fields.toString());

    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    print('=====Response body is here==>${res.body}');

    try {
      return ApiResponse.withSuccess(Response(statusCode: response.statusCode, requestOptions: null, statusMessage: response.reasonPhrase, data: res.body));
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));

    }
  }

}
