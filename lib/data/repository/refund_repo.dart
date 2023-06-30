import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class RefundRepo {
  final DioClient dioClient;
  RefundRepo({@required this.dioClient});

  Future<ApiResponse> getRefundList() async {
    try {
      final response = await dioClient.get(AppConstants.REFUND_LIST_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRefundReqDetails(int orderDetailsId) async {
    try {
      final response = await dioClient.get('${AppConstants.REFUND_ITEM_DETAILS}?order_details_id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> refundStatus(int refundId , String status, String note) async {
    print('update order status ====>${refundId.toString()} =======>${status.toString()}  =======>${note.toString()}');
    try {
      Response response = await dioClient.post(
        '${AppConstants.REFUND_REQ_STATUS_UPDATE}',
        data: {'refund_status': status, 'refund_request_id': refundId, 'note' : note},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRefundStatusList(String type) async {
    try {
      List<String> refundTypeList = [];

      refundTypeList = [
          'Select Refund Status',
          AppConstants.APPROVED,
          AppConstants.REJECTED,

        ];
      Response response = Response(requestOptions: RequestOptions(path: ''), data: refundTypeList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
