import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';


class ProductRepo {
  final DioClient dioClient;
  ProductRepo({@required this.dioClient});

  Future<ApiResponse> getSellerProductList(String sellerId, int offset, String languageCode, String search ) async {
    try {
      final response = await dioClient.get(
        AppConstants.SELLER_PRODUCT_URI+sellerId+'/all-products?limit=10&&offset=$offset&search=$search',
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getPosProductList(int offset) async {
    try {
      final response = await dioClient.get('${AppConstants.POS_PRODUCT_LIST}?limit=10&&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSearchedPosProductList(String search, List <String> _ids) async {
    try {
      final response = await dioClient.get('${AppConstants.SEARCH_POS_PRODUCT_LIST}?limit=10&offset=1&name=$search&category_id=${jsonEncode(_ids)}');
      print('==here is my url===${AppConstants.SEARCH_POS_PRODUCT_LIST}?limit=10&offset=1&name=$search&category_id=${jsonEncode(_ids)}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }





  Future<ApiResponse> getStockLimitedProductList(int offset, String languageCode ) async {
    try {
      final response = await dioClient.get('${AppConstants.STOCK_OUT_PRODUCT_URI}$offset',
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMostPopularProductList(int offset, String languageCode ) async {
    try {
      final response = await dioClient.get('${AppConstants.MOST_POPULAR_PRODUCT}$offset',
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getTopSellingProductList(int offset, String languageCode ) async {
    try {
      final response = await dioClient.get('${AppConstants.TOP_SELLING_PRODUCT}$offset',
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getProductWiseReviewList(int productId,int offset) async {
    try {
      final response = await dioClient.get('${AppConstants.PRODUCT_WISE_REVIEW_LIST}$productId?limit=10&offset=$offset',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductDetails(int productId) async {
    try {
      final response = await dioClient.get('${AppConstants.PRODUCT_DETAILS}$productId',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> updateProductQuantity(int productId,int currentStock, List <Variation> variation) async {
    try {
      final response = await dioClient.post('${AppConstants.UPDATE_PRODUCT_QUANTITY}',
        data: {
          "product_id": productId,
          "current_stock": currentStock,
          "variation" : [],
          "_method":"put"
        }
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> productStatusOnOff(int productId, int status) async {
    try {
      final response = await dioClient.post('${AppConstants.PRODUCT_STATUS_ON_OFF}',
          data: {
            "id": productId,
            "status": status,
            "_method":"put"
          }
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> barCodeDownLoad(int id, int quantity) async {
    try {
      final response = await dioClient.get('${AppConstants.BAR_CODE_GENERATE}?id=$id&quantity=$quantity',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}