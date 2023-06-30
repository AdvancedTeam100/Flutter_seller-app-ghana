import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/body/seller_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/seller_info.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class BankInfoRepo {

  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  BankInfoRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getBankList() async {
    try {
      final response = await dioClient.get(AppConstants.SELLER_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> chartFilterData(String type) async {
    try {
      final response = await dioClient.get('${AppConstants.CHART_FILTER_DATA}$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<http.StreamedResponse> updateBank(SellerModel userInfoModel, SellerBody seller, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SELLER_AND_BANK_UPDATE}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});

    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put', 'bank_name': userInfoModel.bankName, 'branch': userInfoModel.branch,
      'holder_name': userInfoModel.holderName, 'account_no': userInfoModel.accountNo,
      'f_name': seller.fName, 'l_name': seller.lName, 'phone': userInfoModel.phone
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  String getBankToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
}
