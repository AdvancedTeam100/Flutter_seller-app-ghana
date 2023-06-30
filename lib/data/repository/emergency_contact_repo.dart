
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:flutter/foundation.dart';


class EmergencyContactRepo {
  final DioClient dioClient;
  EmergencyContactRepo({@required this.dioClient});

  Future<ApiResponse> getEmergencyContactListList() async {
    try {
      final response = await dioClient.get(AppConstants.GET_EMERGENCY_CONTACT_LIST);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> addNewEmergencyContact(String name, String phone,int id, {bool isUpdate = false}) async {
    try {
      print('==id=$id, name=$name, phone = $phone, isUpdate=$isUpdate');
      final response = await dioClient.post(isUpdate? AppConstants.EMERGENCY_CONTACT_UPDATE : AppConstants.EMERGENCY_CONTACT_ADD,
          data: {
            'id': id,
            'name' : name,
            'phone' : phone,
            '_method' : isUpdate? 'put' :'post'


          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> statusOnOffEmergencyContact(int id, int status) async {
    try {
      final response = await dioClient.post(AppConstants.EMERGENCY_CONTACT_STATUS_ON_OFF,
          data: {'_method': 'put',
            'id' : id,
            'status' : status
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> deleteEmergencyContact(int id) async {
    try {
      final response = await dioClient.post('${AppConstants.EMERGENCY_CONTACT_DELETE}', data: {
        '_method': 'delete',
        'id' : id
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}