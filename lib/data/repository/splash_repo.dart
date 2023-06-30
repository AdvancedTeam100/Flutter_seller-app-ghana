import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient.get(AppConstants.CONFIG_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  void initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.SEARCH_ADDRESS)) {
      sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.CURRENCY)) {
      sharedPreferences.setString(AppConstants.CURRENCY, '');
    }
  }

  String getCurrency() {
    return sharedPreferences.getString(AppConstants.CURRENCY) ?? '';
  }

  void setCurrency(String currencyCode) {
    sharedPreferences.setString(AppConstants.CURRENCY, currencyCode);
  }
  void setShippingType(String shippingType) {
    sharedPreferences.setString(AppConstants.SHIPPING_TYPE, shippingType);
  }

  Future<ApiResponse> getShippingTypeList(BuildContext context, String type) async {
    try {
      List<String> shippingTypeList = [];
      shippingTypeList = [
        'order_wise',
        'product_wise',
        'category_wise'
        ];


      Response response = Response(requestOptions: RequestOptions(path: ''), data: shippingTypeList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
