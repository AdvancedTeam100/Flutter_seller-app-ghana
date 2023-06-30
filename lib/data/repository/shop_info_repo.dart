
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/shop_info_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ShopRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ShopRepo({@required this.dioClient, @required this.sharedPreferences});


  Future<ApiResponse> getShop() async {
    try {
      final response = await dioClient.get(AppConstants.SHOP_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<http.StreamedResponse> updateShop(ShopModel userInfoModel,  File file, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SHOP_UPDATE}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if(file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put', 'name': userInfoModel.name, 'address': userInfoModel.address, 'contact': userInfoModel.contact
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  String getShopToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }


  Future<ApiResponse> vacation(String startDate, String endDate, vacationNote, int status) async {
    try {
      final response = await dioClient.post(AppConstants.VACATION,
      data: {
        "vacation_start_date" : startDate,
        "vacation_end_date" : endDate,
        "vacation_note" : vacationNote,
        "_method": "put",
        "vacation_status" : status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> temporaryClose(int status) async {
    try {
      final response = await dioClient.post(AppConstants.TEMPORARY_CLOSE,data: {
        '_method' : "put",
        'status' : status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}