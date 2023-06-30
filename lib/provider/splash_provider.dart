import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/config_model.dart';
import 'package:sixvalley_vendor_app/data/repository/splash_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({@required this.splashRepo});

  ConfigModel _configModel;
  BaseUrls _baseUrls;
  CurrencyList _myCurrency;
  CurrencyList _defaultCurrency;
  CurrencyList _usdCurrency;
  int _currencyIndex;
  int _shippingIndex;
  bool _hasConnection = true;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;
  List<String> _unitList;
  List<ColorList> _colorList;
  int _unitIndex = 0;
  int _colorIndex = 0;
  List<String> get unitList => _unitList;
  List<ColorList> get colorList => _colorList;
  int get unitIndex => _unitIndex;
  int get colorIndex =>_colorIndex;
  List<String> _shippingTypeList = [];
  String _shippingStatusType = '';
  List<String> get shippingTypeList => _shippingTypeList;
  String get shippingStatusType => _shippingStatusType;







  ConfigModel get configModel => _configModel;
  BaseUrls get baseUrls => _baseUrls;
  CurrencyList get myCurrency => _myCurrency;
  CurrencyList get defaultCurrency => _defaultCurrency;
  CurrencyList get usdCurrency => _usdCurrency;
  int get currencyIndex => _currencyIndex;
  int get shippingIndex => _shippingIndex;
  bool get hasConnection => _hasConnection;
  bool get fromSetting => _fromSetting;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> initConfig(BuildContext context) async {
    _hasConnection = true;
    ApiResponse apiResponse = await splashRepo.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response.data).baseUrls;
      String _currencyCode = splashRepo.getCurrency();
      for(CurrencyList currencyList in _configModel.currencyList) {
        if(currencyList.id == _configModel.systemDefaultCurrency) {
          if(_currencyCode == null || _currencyCode.isEmpty) {
            _currencyCode = currencyList.code;
          }
          _defaultCurrency = currencyList;
        }
        if(currencyList.code == 'USD') {
          _usdCurrency = currencyList;
        }
      }

      getCurrencyData(_currencyCode);
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(context, apiResponse);
      if(apiResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void getCurrencyData(String currencyCode) {
    _configModel.currencyList.forEach((currency) {
      if(currencyCode == currency.code) {
        _myCurrency = currency;
        _currencyIndex = _configModel.currencyList.indexOf(currency);
        return;
      }
    });
  }

  Future<List<int>> getColorList() async {
    List<int> _colorIds = [];
    _colorList = [];
    for (ColorList item in _configModel.colors) {
      _colorList.add(item);
      _colorIds.add(item.id);
    }
    // notifyListeners();
    return _colorIds;
  }



  void setCurrency(int index) {
    splashRepo.setCurrency(_configModel.currencyList[index].code);
    getCurrencyData(_configModel.currencyList[index].code);
    notifyListeners();
  }
  void setShippingType(int index) {
    splashRepo.setShippingType(_shippingTypeList[index]);
    notifyListeners();
  }

  void initShippingType(String type) {
    _shippingIndex = _shippingTypeList.indexOf(type);
    notifyListeners();
  }


  void initSharedPrefData() {
    splashRepo.initSharedData();
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }




  void initShippingTypeList(BuildContext context, String type) async {
    ApiResponse apiResponse = await splashRepo.getShippingTypeList(context,type);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _shippingTypeList.clear();
      _shippingTypeList =[];
      _shippingTypeList.addAll(apiResponse.response.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
