import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/body/seller_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/seller_info.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ProfileRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getSellerInfo() async {
    try {
      final response = await dioClient.get(AppConstants.SELLER_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateProfile(SellerModel userInfoModel, SellerBody seller,  File file, String token, String password) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SELLER_AND_BANK_UPDATE}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    Map<String, String> _fields = Map();
    if(file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
    _fields.addAll(<String, String>{
      '_method': 'put', 'f_name': userInfoModel.fName, 'l_name': userInfoModel.lName, 'phone': userInfoModel.phone,
    });
    if(password.isNotEmpty) {
      _fields.addAll({'password': password});
    }
    print(_fields.toString());
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  Future<ApiResponse> withdrawBalance(List <String> typeKey, List<String> typeValue,int id, String balance) async {
    try {
      Map<String, String> _fields = new Map();

      for(var i = 0; i < typeKey.length; i++){
        _fields.addAll(<String, String>{
          typeKey[i] : typeValue[i]
        });
        print('--here is type key =${typeKey.toList()}/${typeValue.toList()}');
      }
      _fields.addAll(<String, String>{
        'amount': balance,
        'withdraw_method_id': id.toString()
      });


      print('--here is type key =$id');


      Response response = await dioClient.post( AppConstants.BALANCE_WITHDRAW,
          data: _fields);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteUserAccount() async {
    try {
      final response = await dioClient.get('${AppConstants.DELETE_ACCOUNT}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDynamicWithDrawMethod() async {
    try {
      final response = await dioClient.get('${AppConstants.DYNAMIC_WITHDRAW_METHOD}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}