import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_details_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/data/repository/refund_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class RefundProvider extends ChangeNotifier {
  final RefundRepo refundRepo;
  RefundProvider({@required this.refundRepo});


  List<RefundModel> _refundList;
  List<RefundModel> get refundList => _refundList != null ? _refundList : _refundList;

  List<RefundModel> _pendingList;
  List<RefundModel> _approvedList;
  List<RefundModel> _deniedList;
  List<RefundModel> _doneList;

  List<RefundModel> get pendingList => _pendingList != null ? _pendingList : _pendingList;
  List<RefundModel> get approvedList => _approvedList != null ? _approvedList : _approvedList;
  List<RefundModel> get deniedList => _deniedList != null ? _deniedList : _deniedList;
  List<RefundModel> get doneList => _doneList != null ? _doneList : _doneList;



  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _refundTypeIndex = 0;
  int get refundTypeIndex => _refundTypeIndex;

  List<String> _refundStatusList = [];
  String _refundStatusType = '';
  List<String> get refundStatusList => _refundStatusList;
  String get refundStatusType => _refundStatusType;

  RefundDetailsModel _refundDetailsModel;
  RefundDetailsModel get refundDetailsModel => _refundDetailsModel;
  bool _isSendButtonActive = false;
  bool get isSendButtonActive => _isSendButtonActive;
  bool _adminReplied = true;
  bool get adminReplied => _adminReplied;




  Future<ApiResponse> updateRefundStatus(BuildContext context,int id, String status, String note) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    apiResponse = await refundRepo.refundStatus(id, status, note);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      showCustomSnackBar(getTranslated('successfully_updated_refund_status', context), context,isError: false);
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> getRefundReqInfo(BuildContext context, int orderDetailId) async {
    _isLoading = true;

    ApiResponse apiResponse = await refundRepo.getRefundReqDetails(orderDetailId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _refundDetailsModel = RefundDetailsModel.fromJson(apiResponse.response.data);
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<void> getRefundList(BuildContext context) async {
    ApiResponse apiResponse = await refundRepo.getRefundList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _refundList = [];
      _pendingList = [];
      _approvedList = [];
      _deniedList = [];
      _doneList = [];
      apiResponse.response.data.forEach((refund) {

        RefundModel refundModel = RefundModel.fromJson(refund);
        _refundList.add(refundModel);
        if (refundModel.status == AppConstants.PENDING) {
          _pendingList.add(refundModel);
        } else if (refundModel.status == AppConstants.APPROVED) {
          _approvedList.add(refundModel);
        }else if (refundModel.status == AppConstants.REJECTED) {
          _deniedList.add(refundModel);
        }else if (refundModel.status == AppConstants.DONE) {
          _doneList.add(refundModel);
        }
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  void setIndex(int index) {
    _refundTypeIndex = index;
    notifyListeners();
  }

  void updateStatus(String value) {
    _refundStatusType = value;
    notifyListeners();
  }


}
