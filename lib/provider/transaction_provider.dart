import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/month_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/transaction_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/year_model.dart';
import 'package:sixvalley_vendor_app/data/repository/transaction_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepo transactionRepo;

  TransactionProvider({@required this.transactionRepo});

  List<TransactionModel> _transactionList;
  List<TransactionModel> _allTransactionList;
  List<TransactionModel> get transactionList => _transactionList;



  List<MonthModel>  _monthItemList = [];
  List<MonthModel> get monthItemList => _monthItemList;
  List<YearModel>  _yearList = [];
  List<YearModel> get yearList => _yearList;
  int _yearIndex = 0;
  int _monthIndex = 0;
  int get yearIndex => _yearIndex;
  int get monthIndex => _monthIndex;
  List<int> _yearIds = [];
  List<int> _monthIds = [];
  List<int> get yearIds  => _yearIds;
  List<int> get monthIds  => _monthIds;


  int _transactionTypeIndex = 0;
  int get transactionTypeIndex => _transactionTypeIndex;

  void setIndex(BuildContext context, int index) {
    _transactionTypeIndex = index;
    if(_transactionTypeIndex == 0){
      getTransactionList(context, 'all', '','');
    }else if(_transactionTypeIndex == 1){
      getTransactionList(context, 'pending', '','');
    }else if(_transactionTypeIndex == 2){
      getTransactionList(context, 'approve', '','');
    }else if(_transactionTypeIndex == 3){
      getTransactionList(context, 'deny', '','');
    }
    notifyListeners();
  }

  void setYearIndex(int index, bool notify) {
    _yearIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  void setMonthIndex(int index, bool notify) {
    _monthIndex = index;
    if(notify) {
      notifyListeners();
    }
  }


  Future<void> getTransactionList(BuildContext context, status, from, to) async {
    ApiResponse apiResponse = await transactionRepo.getTransactionList(status, from, to);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _transactionList = [];
      _allTransactionList = [];
      apiResponse.response.data.forEach((transaction) {
        _transactionList.add(TransactionModel.fromJson(transaction));
        _allTransactionList.add(TransactionModel.fromJson(transaction));
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void  filterTransaction(int month, int year, BuildContext context) async {
    if (month == 1) {
      _transactionList = [];
      _transactionList.addAll(_allTransactionList);
    } else {
      _transactionList = [];
      _allTransactionList.forEach((transaction) {
        if(DateConverter.getMonthIndex(transaction.createdAt) == month && DateConverter.getYear(transaction.createdAt) == year) {
          _transactionList.add(transaction);

        }
      });

    }
    notifyListeners();
  }


  void initMonthTypeList() async {
    _monthIds = [];
    _monthIds.add(0);
    ApiResponse apiResponse = await transactionRepo.getMonthTypeList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {

      _monthItemList = [];
      _monthItemList.addAll(apiResponse.response.data);
      _monthIndex = 0;
      for(int index = 0; index < _monthItemList.length; index++) {
        _monthIds.add(_monthItemList[index].id);
      }
      notifyListeners();
    } else {
      print(apiResponse.error.toString());
    }
  }
  void initYearList() async {
    _yearIds = [];
    _yearIds.add(0);
    ApiResponse apiResponse = await transactionRepo.getYearList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _yearList = [];
      _yearList.addAll(apiResponse.response.data);

      _yearIndex = 0;
      for(int index = 0; index < _yearList.length; index++) {
        _yearIds.add(_yearList[index].id);
      }
      notifyListeners();
    } else {
      print(apiResponse.error.toString());
    }
  }


  int _selectedItem = 0;
  int get selectedItem => _selectedItem;
  String _startDate = 'dd-mm-yyyy';
  String get startDate => _startDate;
  String _endDate = 'dd-mm-yyyy';
  String get endDate => _endDate;

  Future <void> selectDate(BuildContext context, String startDate, String endDate) async {
    _startDate = startDate;
    _endDate = endDate;
    getTransactionList(context, 'all', _startDate, _endDate);
    notifyListeners();
  }



}
