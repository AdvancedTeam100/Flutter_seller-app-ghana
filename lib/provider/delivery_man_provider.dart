import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/body/delivery_man_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/collected_cash_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_detail_model.dart' as d;
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_earning_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_order_history_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_review_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_withdraw_detail_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_withdraw_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_history_log_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';
import 'package:sixvalley_vendor_app/data/repository/delivery_man_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class DeliveryManProvider extends ChangeNotifier {
  final DeliveryManRepo deliveryManRepo;
  DeliveryManProvider({@required this.deliveryManRepo});
  List<DeliveryManModel> _deliveryManList;
  List<DeliveryManModel> get  deliveryManList => _deliveryManList;
  List<DeliveryMan> _topDeliveryManList;
  List<DeliveryMan> get topDeliveryManList =>_topDeliveryManList;
  List<DeliveryMan> _listOfDeliveryMan;
  List<DeliveryMan> get listOfDeliveryMan =>_listOfDeliveryMan;

  int _deliveryManIndex = 0;
  int get deliveryManIndex => _deliveryManIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _addOrderStatusErrorText;
  String get addOrderStatusErrorText => _addOrderStatusErrorText;
  List<int> _deliveryManIds = [];
  List<int> get deliveryManIds => _deliveryManIds;

  d.DeliveryManDetails _deliveryManDetails;
  d.DeliveryManDetails get deliveryManDetails =>_deliveryManDetails;


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController identityNumber = TextEditingController();
  TextEditingController addressController = TextEditingController();


  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode identityNumberNode = FocusNode();
  FocusNode addressNode = FocusNode();

  XFile _profileImage;
  XFile get profileImage => _profileImage;
  XFile _identityImage;
  XFile get identityImage => _identityImage;
  List<XFile> _identityImages = [];
  List<XFile> get identityImages => _identityImages;

  List<Order> _deliverymanOrderList = [];
  List<Order> get deliverymanOrderList => _deliverymanOrderList;


  DeliveryManEarning _deliveryManEarning;
  DeliveryManEarning get deliveryManEarning=> _deliveryManEarning;

  List<Earning> _earningList =[];
  List<Earning> get earningList => _earningList;



  void pickImage(bool isProfile, bool isRemove) async {
    if(isRemove) {
      _profileImage = null;
      _identityImages = [];
    }else {
      if (isProfile) {
        _profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      }else {
        _identityImage = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (_identityImage != null) {
          _identityImages.add(_identityImage);

        }
      }
    }

    notifyListeners();

  }


  void removeImage(int index){
    _identityImages.removeAt(index);
    notifyListeners();
  }


  int _selectionTabIndex = 1;
  int get selectionTabIndex =>_selectionTabIndex;
  void setIndexForTabBar(int index, {bool isNotify = true}){
    _selectionTabIndex = index;
    print('here is your current index =====>$_selectionTabIndex');
    if(isNotify){
      notifyListeners();
    }

  }

  Future<void> getDeliveryManList(Order orderModel, BuildContext context) async {
    _deliveryManIds =[];
    _deliveryManIds.add(0);
    _deliveryManIndex = 0;
    ApiResponse apiResponse = await deliveryManRepo.getDeliveryManList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _deliveryManList = [];
      apiResponse.response.data.forEach((deliveryMan) => _deliveryManList.add(DeliveryManModel.fromJson(deliveryMan)));
      _deliveryManIndex = 0;

      for(int index = 0; index < _deliveryManList.length; index++) {
        _deliveryManIds.add(_deliveryManList[index].id);
      }

      if(orderModel.deliveryManId != null){
        setDeliverymanIndex(deliveryManIds.indexOf(int.parse(orderModel.deliveryManId.toString())), false);
      }

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> deliveryManListURI(BuildContext context, int offset, String search, {bool reload = true}) async {

    ApiResponse apiResponse = await deliveryManRepo.deliveryManList(offset, search);
    if(reload){
      _listOfDeliveryMan = [];
      _isLoading = true;
    }
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _listOfDeliveryMan.addAll(TopDeliveryMan.fromJson(apiResponse.response.data).deliveryMan);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getDeliveryManOrderListHistory(BuildContext context, int offset, int deliveryManId, {bool reload = true}) async {
    ApiResponse apiResponse = await deliveryManRepo.deliveryManOrderList(offset, deliveryManId);
    if(reload){
      _deliverymanOrderList = [];
      _isLoading = true;
    }
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _deliverymanOrderList.addAll(DeliveryManOrderHistory.fromJson(apiResponse.response.data).orders);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }



  Future<void> getDeliveryManEarningListHistory(BuildContext context, int offset, int deliveryManId, {bool reload = true}) async {
    ApiResponse apiResponse = await deliveryManRepo.deliveryManEarningList(offset, deliveryManId);
    if(reload){
      _deliveryManEarning = null;

    }
    _isLoading = true;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      if(offset == 1) {
        _deliveryManEarning = DeliveryManEarning.fromJson(apiResponse.response.data);
      }else{
        _deliveryManEarning.totalSize = DeliveryManEarning.fromJson(apiResponse.response.data).totalSize;
        _deliveryManEarning.offset = DeliveryManEarning.fromJson(apiResponse.response.data).offset;
        _deliveryManEarning.orders.addAll(DeliveryManEarning.fromJson(apiResponse.response.data).orders);
      }

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }


  Future<void> getDeliveryManDetails(BuildContext context, int deliveryManId) async {
    _isLoading = true;
    ApiResponse apiResponse = await deliveryManRepo.deliveryManDetails(deliveryManId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _deliveryManDetails = d.DeliveryManDetails.fromJson(apiResponse.response.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getTopDeliveryManList(BuildContext context, {bool reload = true}) async {
    if(reload){
      _isLoading = false;
      _topDeliveryManList = [];
    }
    _isLoading = true;
    ApiResponse apiResponse = await deliveryManRepo.getTopDeliveryManList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _topDeliveryManList.addAll(TopDeliveryMan.fromJson(apiResponse.response.data).deliveryMan);

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }


  List<OrderHistoryLogModel> _changeLogList =[];
  List<OrderHistoryLogModel> get changeLogList => _changeLogList;

  Future<void> getDeliveryManOrderHistoryLogList(BuildContext context, int orderId) async {

    _isLoading = true;
    ApiResponse apiResponse = await deliveryManRepo.getDeliverymanOrderHistoryLog(orderId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {

      _changeLogList =[];
      apiResponse.response.data.forEach((changeLog){
        OrderHistoryLogModel log = OrderHistoryLogModel.fromJson(changeLog);
        _changeLogList.add(log);
      });

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }


  List<String> _deliveryTypeList = ['select_delivery_type','by_self_delivery_man', 'by_third_party_delivery_service'];
  List<String> get deliveryTypeList => _deliveryTypeList;

  int _selectedDeliveryTypeIndex = 0;
  int get selectedDeliveryTypeIndex => _selectedDeliveryTypeIndex;

  void setDeliveryTypeIndex(int index, bool notify){
    _selectedDeliveryTypeIndex = index;
    if(notify){
      notifyListeners();
    }

  }


  Future<void> assignDeliveryMan(BuildContext context,int orderId, int deliveryManId) async {
    _isLoading = true;
    ApiResponse apiResponse;
    apiResponse = await deliveryManRepo.assignDeliveryMan(orderId, deliveryManId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Provider.of<OrderProvider>(context, listen: false).getOrderList(context, 1,'all');
      Provider.of<OrderProvider>(context, listen: false).getOrderDetails(orderId.toString(), context);
      _isLoading = false;
      showCustomSnackBar(getTranslated('delivery_man_assign_successfully', context), context, isToaster: true, isError: false);

    } else {
      _isLoading = false;
     ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();

  }

  Future<void> deliveryManStatusOnOff(BuildContext context,int id, int status) async {
    _isLoading = true;
    ApiResponse apiResponse;
    apiResponse = await deliveryManRepo.deliveryManStatusOnOff(id, status);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      getDeliveryManDetails(context,id);
      _deliveryManDetails.deliveryMan.isActive = status;
      _isLoading = false;
      showCustomSnackBar(getTranslated('status_updated_successfully', context), context, isToaster: true, isError: false);
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();

  }



  Future<void> collectCashFromDeliveryMan(BuildContext context, int deliveryManId, String amount) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    apiResponse = await deliveryManRepo.collectCashFromDeliveryMan(deliveryManId, amount);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      Navigator.pop(context);
      getDeliveryManDetails(context, deliveryManId);
     showCustomSnackBar(getTranslated('amount_collected_from_deliveryman', context), context, isToaster: true);
    }else{
      _isLoading = false;
      Map map = apiResponse.response.data;
      showCustomSnackBar(map['message'], context, isToaster: true);
    }
    notifyListeners();

  }


  Future<void> deleteDeliveryMan(BuildContext context, int deliveryManId) async {
    ApiResponse apiResponse;
    apiResponse = await deliveryManRepo.deleteDeliveryMan(deliveryManId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      deliveryManListURI(context, 1,'');
      String message = apiResponse.response.data['message'];
      showCustomSnackBar(message, context, isError: false);
    }
    notifyListeners();

  }


  void setDeliverymanIndex(int index, bool notify) {
    _deliveryManIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  List<String> _identityTypeList = ['passport', 'Driving Licence', 'Nid', 'Company Id' ];
  List<String> get identityTypeList => _identityTypeList;

  String _identityType;
  String get identityType => _identityType;

  void setIdentityType (String setValue){
    print('------$setValue====$_identityType');
    _identityType = setValue;

  }
  String _countryDialCode = '+880';
  String get countryDialCode => _countryDialCode;

  void setCountryDialCode (String setValue){
    print('------$setValue====$_identityType');
    _countryDialCode = setValue;

  }



  Future<ApiResponse> addNewDeliveryMan(BuildContext context, DeliveryManBody deliveryManBody, {bool isUpdate = false}) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse  response = await deliveryManRepo.addNewDeliveryMan(_profileImage, _identityImages,
        deliveryManBody, Provider.of<AuthProvider>(context, listen: false).getUserToken(), isUpdate: isUpdate);
    if(response.response.statusCode == 200) {
      _isLoading = false;
      firstNameController.clear();
      lastNameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      identityNumber.clear();
      addressController.clear();
      _profileImage = null;
      _identityImage = null;
      _identityImages = [];
      isUpdate?
      showCustomSnackBar(getTranslated("delivery_man_updated_successfully", context), context, isError: false):
      showCustomSnackBar(getTranslated("delivery_man_added_successfully", context), context, isError: false);
    }else {
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
    return response;
  }

  List<Withdraws> _withdrawList = [];
  List<Withdraws> get withdrawList => _withdrawList;

  List<DeliveryManReview> _deliveryManReviewList = [];
  List<DeliveryManReview> get deliveryManReviewList => _deliveryManReviewList;

  Details _details;
  Details get details => _details;

  Future<void> getDeliveryManWithdrawDetails(BuildContext context, int id) async {
    _isLoading = true;
    ApiResponse apiResponse = await deliveryManRepo.deliveryManWithdrawDetails(id);

    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _details = DeliveryManWithdrawDetailModel.fromJson(apiResponse.response.data).details;

    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }

    notifyListeners();
  }



  Future<void> getDeliveryManWithdrawList(BuildContext context, int offset, String status, {bool reload = true}) async {

    ApiResponse apiResponse = await deliveryManRepo.deliveryManWithdrawList(offset, status);
    if(reload){
      _withdrawList = [];
      _isLoading = true;
    }
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _withdrawList.addAll(DeliveryManWithdrawModel.fromJson(apiResponse.response.data).withdraws);
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }

    notifyListeners();
  }

  Future<void> getDeliveryManReviewList(BuildContext context, int offset, int id , {bool reload = true}) async {
    ApiResponse apiResponse = await deliveryManRepo.getDeliveryManReviewList(offset, id);
    if(reload){
      _deliveryManReviewList = [];
      _isLoading = true;
    }
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _deliveryManReviewList.addAll(DeliveryManReviewModel.fromJson(apiResponse.response.data).reviews);
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }

    notifyListeners();
  }


  Future<void> deliveryManWithdrawApprovedDenied(BuildContext context,int id, String note, int approved, int index) async {
    _isLoading = true;
    ApiResponse apiResponse;
    apiResponse = await deliveryManRepo.deliveryManWithdrawApprovedDenied(id, note, approved);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Navigator.pop(context);
      _withdrawList[index].approved = approved;
      getDeliveryManWithdrawList(context, 1, 'all');
      String message = apiResponse.response.data['message'];
      showCustomSnackBar(message, context, isToaster: true);
    } else {
      String message = apiResponse.response.data['message'];
      showCustomSnackBar(message, context, isToaster: true);
    }
    notifyListeners();

  }


  int _withdrawTypeIndex = 0;
  int get withdrawTypeIndex => _withdrawTypeIndex;

  void setIndex(BuildContext context,int index) {
    _withdrawTypeIndex = index;
    if(_withdrawTypeIndex == 0){
      getDeliveryManWithdrawList(context, 1,'all', reload: true);
    }
    else if(_withdrawTypeIndex == 1){
      getDeliveryManWithdrawList(context, 1,'pending', reload: true);
    }
    else if(_withdrawTypeIndex == 2){
      getDeliveryManWithdrawList(context, 1,'approved', reload: true);
    }else if(_withdrawTypeIndex == 3){
      getDeliveryManWithdrawList(context, 1,'denied', reload: true);
    }
    notifyListeners();
  }


  CollectedCashModel _collectedCashModel;
  CollectedCashModel get collectedCashModel => _collectedCashModel;

  Future<void> getDeliveryCollectedCashList(BuildContext context, int deliveryManId, int offset, {bool reload = true}) async {
    if(reload){
      _collectedCashModel = null;
      _isLoading = true;
    }

    _isLoading = true;
    ApiResponse apiResponse = await deliveryManRepo.getDeliveryManCollectedCashList(deliveryManId, offset);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      if(offset == 1 ){
        _collectedCashModel = CollectedCashModel.fromJson(apiResponse.response.data);
      }else{
        _collectedCashModel.totalSize =  CollectedCashModel.fromJson(apiResponse.response.data).totalSize;
        _collectedCashModel.offset =  CollectedCashModel.fromJson(apiResponse.response.data).offset;
        _collectedCashModel.collectedCash.addAll(CollectedCashModel.fromJson(apiResponse.response.data).collectedCash)  ;
      }

    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }


}