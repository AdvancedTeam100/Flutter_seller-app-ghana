import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/dio/dio_client.dart';
import 'package:sixvalley_vendor_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/month_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/year_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';

class TransactionRepo {
  final DioClient dioClient;
  TransactionRepo({@required this.dioClient});

  Future<ApiResponse> getTransactionList(String status, String from, String to) async {
    try {
      final Response response = await dioClient.get('${AppConstants.TRANSACTIONS_URI}$status&from=$from&to=$to');
      return ApiResponse.withSuccess(response);
    } catch (e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMonthTypeList() async {
    try {
      List<MonthModel> monthTypeList = [
        MonthModel(id: 1, month: 'All'),
        MonthModel(id: 2, month: 'January'),
        MonthModel(id: 3, month: 'February'),
        MonthModel(id: 4, month: 'March'),
        MonthModel(id: 5, month: 'April'),
        MonthModel(id: 6, month: 'May'),
        MonthModel(id: 7, month: 'June'),
        MonthModel(id: 8, month: 'July'),
        MonthModel(id: 9, month: 'August'),
        MonthModel(id: 10, month: 'September'),
        MonthModel(id: 11, month: 'October'),
        MonthModel(id: 12, month: 'November'),
        MonthModel(id: 13, month: 'December'),

      ];
      Response response = Response(requestOptions: RequestOptions(path: ''), data: monthTypeList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getYearList() async {
    try {
      List<YearModel> yearList = [
        YearModel(id: 1, year: '2020'),
        YearModel(id: 2, year: '2021'),
        YearModel(id: 3, year: '2022'),
        YearModel(id: 4, year: '2023'),
        YearModel(id: 5, year: '2024'),
        YearModel(id: 6, year: '2025'),
        YearModel(id: 7, year: '2026'),
        YearModel(id: 8, year: '2027'),
        YearModel(id: 9, year: '2028'),
        YearModel(id: 10, year: '2029'),
        YearModel(id: 11, year: '2030'),
        YearModel(id: 12, year: '2031'),
        YearModel(id: 13, year: '2032'),

      ];
      Response response = Response(requestOptions: RequestOptions(path: ''), data: yearList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
