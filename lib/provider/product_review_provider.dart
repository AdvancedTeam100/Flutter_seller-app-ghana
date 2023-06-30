
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/repository/product_review_repo.dart';
import 'package:sixvalley_vendor_app/data/repository/ratting_model.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class ProductReviewProvider extends ChangeNotifier{
  final ProductReviewRepo productReviewRepo;
  ProductReviewProvider({@required this.productReviewRepo});


  List<Reviews> _reviewList = [];
  List<Reviews> get reviewList => _reviewList;

  List<bool> _isOn = [];
  List<bool> get isOn=>_isOn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;



  List<String> reviewStatusList = ['select_status','active', 'inactive'];
  int _reviewStatusIndex = 0;
  int get reviewStatusIndex => _reviewStatusIndex;
  String _reviewStatusName = 'select_status';
  String get reviewStatusName => _reviewStatusName;

  void setReviewStatusIndex(int index){
    _reviewStatusIndex = index;
    if(_reviewStatusIndex == 0){
      _reviewStatusName = reviewStatusList[0];
    }else if(_reviewStatusIndex == 1){
      _reviewStatusName = reviewStatusList[1];
    }else{
      _reviewStatusName = reviewStatusList[2];
    }
    notifyListeners();
  }


  Future<void> getReviewList(BuildContext context) async{
    _isLoading = true;

    ApiResponse apiResponse = await productReviewRepo.productReviewList();

    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _reviewList = [];


        RattingModel reviewModel = RattingModel.fromJson(apiResponse.response.data);
        _reviewList.addAll(reviewModel.reviews);
        for(Reviews review in _reviewList){
          _isOn.add(review.status == 1? true:false);
        }


      print(reviewList);

    }else{
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
  Future<void> filterReviewList(BuildContext context, int productId, int customerId, ) async{
    ApiResponse apiResponse = await productReviewRepo.filterProductReviewList(productId, customerId,
        _reviewStatusIndex, dateFormat.format(_startDate).toString() , dateFormat.format(_endDate).toString());
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Navigator.pop(context);
      _isLoading = false;
      _reviewList = [];
      RattingModel reviewModel = RattingModel.fromJson(apiResponse.response.data);
      _reviewList.addAll(reviewModel.reviews);
      for(Reviews review in _reviewList){
        _isOn.add(review.status == 1? true:false);
      }
      print(reviewList);

    }else{
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
  Future<void> searchReviewList(BuildContext context, String search) async{
    ApiResponse apiResponse = await productReviewRepo.searchProductReviewList(search);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _reviewList = [];
      RattingModel reviewModel = RattingModel.fromJson(apiResponse.response.data);
      _reviewList.addAll(reviewModel.reviews);
      for(Reviews review in _reviewList){
        _isOn.add(review.status == 1? true:false);
      }
      print(reviewList);

    }else{
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }



  void setToggleSwitch(int index){
    _isOn[index] = !_isOn[index];
    notifyListeners();

  }


  Future<void> reviewStatusOnOff(BuildContext context, int reviewId, int status, int index) async{
    ApiResponse apiResponse = await productReviewRepo.reviewStatusOnOff(reviewId,status);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _reviewList[index].status = status;
      showCustomSnackBar(getTranslated('review_status_updated_successfully', context), context, isError: false);
    }else{
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  DateTime _startDate;
  DateTime _endDate;
  DateFormat _dateFormat = DateFormat('yyyy-MM-d');
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  DateFormat get dateFormat => _dateFormat;

  void selectDate(String type, BuildContext context){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    ).then((date) {
      if (type == 'start'){
        _startDate = date;
      }else{
        _endDate = date;
      }
      if(date == null){
        print('Null');
      }
      notifyListeners();
    });
  }




}