import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class ProductReviewRepo {
  final DioClient dioClient;
  ProductReviewRepo({@required this.dioClient});

  Future<ApiResponse> productReviewList() async {
    try {
      final response = await dioClient.get(AppConstants.PRODUCT_REVIEW_URI,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> filterProductReviewList(int productId, int customerId, int status, String from, String to) async {
    try {
      final response = await dioClient.get('${AppConstants.PRODUCT_REVIEW_URI}?product_id=$productId&customer_id=$customerId&status&from=$from&to=$to',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> searchProductReviewList(String search) async {
    try {
      final response = await dioClient.get('${AppConstants.PRODUCT_REVIEW_URI}?search=$search',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> reviewStatusOnOff(int reviewId, int status) async {
    try {
      final response = await dioClient.get('${AppConstants.PRODUCT_REVIEW_STATUS_ON_OFF}?id=$reviewId&status=$status',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}