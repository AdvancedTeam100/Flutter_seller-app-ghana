import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class OrderRepo {
  final DioClient dioClient;
  OrderRepo({@required this.dioClient});

  Future<ApiResponse> getOrderList(int offset, String status) async {
    try {
      final response = await dioClient.get('${AppConstants.ORDER_LIST_URI}?limit=10&offset=$offset&status=$status');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_DETAILS+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> setDeliveryCharge(int orderID, String deliveryCharge, String expectedDeliveryDate) async {
    try {
      final response = await dioClient.post(AppConstants.DELIVERY_CHARGE_FOR_DELIVERY, data: {
        "order_id": orderID,
        "_method" : "put",
        "deliveryman_charge": deliveryCharge,
        "expected_delivery_date" : expectedDeliveryDate
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> orderStatus(int orderID , String status) async {
    print('update order status ====>${orderID.toString()} =======>${status.toString()}');
    try {
      Response response = await dioClient.post(
        '${AppConstants.UPDATE_ORDER_STATUS}$orderID',
        data: {'_method': 'put', 'order_status': status},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderStatusList(String type) async {
    try {
      List<String> addressTypeList = [];
      if(type == 'inhouse_shipping'){
        addressTypeList = [
          'pending',
          'confirmed',
          'processing'
        ];
      }else{
        addressTypeList = [
          'pending',
          'confirmed',
          'processing',
          'out_for_delivery',
          'delivered',
          'returned',
          'failed',
          'cancelled',
        ];
      }

      Response response = Response(requestOptions: RequestOptions(path: ''), data: addressTypeList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updatePaymentStatus({int orderId, String status}) async {
    try {
      Response response = await dioClient.post(AppConstants.PAYMENT_STATUS_UPDATE,
        data: {"order_id": orderId, "payment_status": status},);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }



  }

  Future<ApiResponse> getInvoiceData(int orderId) async {
    try {
      final response = await dioClient.get('${AppConstants.INVOICE}?id=$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getOrderFilterData(String type) async {
    try {
      final response = await dioClient.get('${AppConstants.BUSINESS_ANALYTICS}$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> assignThirdPartyDeliveryMan(String name,String trackingId, int orderId) async {
    try {
      final response = await dioClient.post('${AppConstants.THIRD_PARTY_DELIVERY_MAN_ASSIGN}',
          data: {'delivery_service_name' : name, 'third_party_delivery_tracking_id' : trackingId, 'order_id' : orderId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}
