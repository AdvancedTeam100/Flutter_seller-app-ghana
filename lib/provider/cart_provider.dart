import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/body/customer_body.dart';
import 'package:sixvalley_vendor_app/data/model/body/place_order_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/customer_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/temporary_cart_for_customer.dart';
import 'package:sixvalley_vendor_app/data/repository/cart_repo.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/screens/order/invoice_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/product_variation_selection_dialog.dart';


class CartProvider extends ChangeNotifier{
  final CartRepo cartRepo;
  CartProvider({@required this.cartRepo});


  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;
  double _amount = 0.0;
  double get amount => _amount;
  double _productDiscount = 0.0;
  double get productDiscount => _productDiscount;

  double _productTax = 0.0;
  double get productTax => _productTax;

  List<TemporaryCartListModel> _customerCartList = [];
  List<TemporaryCartListModel> get customerCartList => _customerCartList;


  TextEditingController _collectedCashController = TextEditingController();
  TextEditingController get collectedCashController => _collectedCashController;

  TextEditingController _customerWalletController = TextEditingController();
  TextEditingController get customerWalletController => _customerWalletController;




  TextEditingController _couponController = TextEditingController();
  TextEditingController get couponController => _couponController;

  TextEditingController _extraDiscountController = TextEditingController();
  TextEditingController get extraDiscountController => _extraDiscountController;

  double _returnToCustomerAmount = 0 ;
  double get returnToCustomerAmount => _returnToCustomerAmount;

  double _couponCodeAmount = 0;
  double get couponCodeAmount =>_couponCodeAmount;
  String _couponCodeApplied = '';
  String get couponCodeApplied => _couponCodeApplied;

  double _extraDiscountAmount = 0;
  double get extraDiscountAmount =>_extraDiscountAmount;

  int _discountTypeIndex = 0;
  int get discountTypeIndex => _discountTypeIndex;


  String _selectedDiscountType = '';
  String get selectedDiscountType =>_selectedDiscountType;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _singleClick = false;
  bool get singleClick => _singleClick;

  Product _scanProduct ;
  Product get scanProduct=>_scanProduct;

  List<bool> _isSelectedList = [];
  List<bool> get isSelectedList => _isSelectedList;

  int _customerIndex = 0;
  int get customerIndex => _customerIndex;

  List<int> _customerIds = [];
  List<int> get customerIds => _customerIds;

  List<CartModel> _existInCartList;
  List<CartModel> get existInCartList =>_existInCartList;


  List<Customers> _searchedCustomerList;
  List<Customers> get searchedCustomerList =>_searchedCustomerList;

  bool _isGetting = false;
  bool _isFirst = true;
  bool get isFirst => _isFirst;
  bool get isGetting => _isGetting;

  int _customerListLength = 0;
  int get customerListLength => _customerListLength;



  String _customerSelectedName = '';
  String get customerSelectedName => _customerSelectedName;

  String _customerSelectedMobile = '';
  String get customerSelectedMobile => _customerSelectedMobile;

  int _customerId = 0;
  int get customerId => _customerId;

  TextEditingController _searchCustomerController = TextEditingController();
  TextEditingController get searchCustomerController => _searchCustomerController;
  double _customerBalance = 0.0;
  double get customerBalance=> _customerBalance;
  int cartIndex = 0;


  void setSelectedDiscountType(String type){
    _selectedDiscountType = type;
    notifyListeners();
  }

  void setDiscountTypeIndex(int index, bool notify) {
    _discountTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  int _paymentTypeIndex = 0;
  int get paymentTypeIndex => _paymentTypeIndex;
  void setPaymentTypeIndex(int index, bool notify) {
    _paymentTypeIndex = index;
    if(notify) {
      notifyListeners();
    }
  }



  void getReturnAmount( double totalCostAmount){
    setReturnAmountToZero();

    if(_customerId != 0){
      _customerWalletController.text = _customerBalance.toString();
      _returnToCustomerAmount = double.parse(_customerWalletController.text) - totalCostAmount;
    }
    else if(_collectedCashController.text.isNotEmpty){
      _returnToCustomerAmount = double.parse(_collectedCashController.text) - totalCostAmount;
    }


    notifyListeners();
  }

  void applyCouponCodeAndExtraDiscount(BuildContext context){
    String extraDiscount = _extraDiscountController.text.trim()?? '0';
    _extraDiscountAmount = double.parse(extraDiscount);
    if(_extraDiscountAmount > _amount){
      showCustomSnackBar(getTranslated('discount_cant_greater_than_order_amount', context),context,isToaster: true);

    }else{
      _customerCartList[_customerIndex].extraDiscount = _extraDiscountAmount;
      showCustomSnackBar(getTranslated('extra_discount_added_successfully', context),context,isToaster: true, isError: false);
    }

    notifyListeners();

  }

  void setReturnAmountToZero()
  {
    _returnToCustomerAmount = 0;
    notifyListeners();
  }



  void addToCart(BuildContext context, CartModel cartModel, {bool decreaseQuantity= false}) {
    _amount = 0;
    if(_customerCartList.isEmpty){
      TemporaryCartListModel customerCart = TemporaryCartListModel(
          cart: [],
          userIndex: 0,
          userId: 0,
          customerName: 'wc-0');
      addToCartListForUser(customerCart, clear: false);

    }
    if (_customerCartList[_customerIndex].cart.any((e) => e.product.id == cartModel.product.id)) {
      isExistInCart(context, cartModel, decreaseQuantity: decreaseQuantity);
    }else{
      _customerCartList[_customerIndex].cart.add(cartModel);

      for(int i = 0; i< _customerCartList[_customerIndex].cart.length; i++){
        _amount = _amount + (_customerCartList[_customerIndex].cart[i].price *
            _customerCartList[_customerIndex].cart[i].quantity);
      }

      showCustomSnackBar(getTranslated('added_cart_successfully', context),context ,isToaster: true, isError: false);

    }

    notifyListeners();
  }


  void addToCartListForUser(TemporaryCartListModel cartList,{bool clear = false}) {
    if(_customerCartList.isEmpty){
      _customerIds = [];
    }

    if (_customerCartList.any((e) => e.userId == cartList.userId && cartList.userId != 0)) {
      _customerCartList.removeAt(_customerIds.indexOf(cartList.userIndex));
      print('already user exist');
    }else{
      _customerIds.add(_customerIds.length);
      _customerCartList.add(cartList);
      if(clear){

        notifyListeners();
      }
    }



  }


  void setQuantity(BuildContext context, bool isIncrement, int index) {
    _amount = 0;
    if (isIncrement) {
      if(_customerCartList[_customerIndex].cart[index].product.currentStock > _customerCartList[_customerIndex].cart[index].quantity && _customerCartList[_customerIndex].cart[index].product.productType == 'physical')
      {
        _customerCartList[_customerIndex].cart[index].quantity = _customerCartList[_customerIndex].cart[index].quantity + 1;
        showCustomSnackBar(getTranslated('quantity_updated', context), context, isToaster: true);

        for(int i =0 ; i< _customerCartList[_customerIndex].cart.length; i++){
          _amount = _amount + (_customerCartList[_customerIndex].cart[i].price *
              _customerCartList[_customerIndex].cart[i].quantity);
        }

      }else if(_customerCartList[_customerIndex].cart[index].product.productType == 'digital')
      {
        _customerCartList[_customerIndex].cart[index].quantity = _customerCartList[_customerIndex].cart[index].quantity + 1;
        showCustomSnackBar(getTranslated('quantity_updated', context), context, isToaster: true, isError: false);

        for(int i =0 ; i< _customerCartList[_customerIndex].cart.length; i++){
          _amount = _amount + (_customerCartList[_customerIndex].cart[i].price *
              _customerCartList[_customerIndex].cart[i].quantity);
        }

      }else{
        showCustomSnackBar(getTranslated('stock_out', context), context, isToaster: true);
      }
    } else {
      if(_customerCartList[_customerIndex].cart[index].quantity > 1){
        showCustomSnackBar(getTranslated('quantity_updated', context), context, isToaster: true);
        _customerCartList[_customerIndex].cart[index].quantity = _customerCartList[_customerIndex].cart[index].quantity - 1;
        for(int i =0 ; i< _customerCartList[_customerIndex].cart.length; i++){
          _amount = _amount + (_customerCartList[_customerIndex].cart[i].price *
              _customerCartList[_customerIndex].cart[i].quantity);
        }
      }else{
        showCustomSnackBar(getTranslated('minimum_quantity_1', context), context, isToaster: true);
        for(int i =0 ; i< _customerCartList[_customerIndex].cart.length; i++){
          _amount = _amount + (_customerCartList[_customerIndex].cart[i].price *
              _customerCartList[_customerIndex].cart[i].quantity);
        }
      }

    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    _amount = _amount - (_customerCartList[_customerIndex].cart[index].price * _customerCartList[_customerIndex].cart[index].quantity);
    _customerCartList[_customerIndex].cart.removeAt(index);
    //print('==bb====>${_customerCartList[_customerIndex].cart.length}');
    notifyListeners();
  }
  void removeAllCart() {
    _cartList = [];
    _collectedCashController.clear();
    _extraDiscountAmount = 0;
    _amount = 0;
    _collectedCashController.clear();
    _customerCartList = [];


    notifyListeners();
  }


  void removeAllCartList() {
    _cartList =[];
    _customerWalletController.clear();
    _extraDiscountAmount = 0;
    _amount = 0;
    _collectedCashController.clear();
    _customerCartList =[];
    _customerIds = [];
    _customerIndex = 0;
    searchCustomerController.text = 'walking customer';
    setCustomerInfo( 0,  'walking customer', 'NULL', true);
    notifyListeners();
  }



  void clearCartList() {
    print('==bb====>${_customerCartList.length}');
    _cartList = [];
    _amount = 0;
    notifyListeners();
  }

  bool isExistInCart(BuildContext context,CartModel cartModel, {bool decreaseQuantity= false}) {
    cartIndex = 0;
    for(int index = 0; index<_customerCartList[_customerIndex].cart.length; index++) {
      if(_customerCartList[_customerIndex].cart[index].product.id == cartModel.product.id) {
        if(decreaseQuantity){
          setQuantity(context, false, index);
          showCustomSnackBar('1 ${getTranslated('item', context)} ${getTranslated('remove_from_cart_successfully', context)}',context, isToaster: true, isError: false);
        }else{
          setQuantity(context, true, index);
          showCustomSnackBar('${getTranslated('added_cart_successfully', context)} ${ _customerCartList[_customerIndex].cart[index].quantity} ${getTranslated('items', context)}',context, isToaster: true, isError: false);
        }


      }
    }
    return false;
  }

  Future<void> getCouponDiscount(BuildContext context,String couponCode, int userId, double orderAmount) async {
    ApiResponse response = await cartRepo.getCouponDiscount(couponCode, userId, orderAmount);
    if(response.response.statusCode == 200) {
      _couponController.clear();
      Map map = response.response.data;
      _couponCodeAmount = map['coupon_discount_amount'].toDouble();
      _customerCartList[_customerIndex].couponAmount = _couponCodeAmount;
      _customerCartList[_customerIndex].couponCode = couponCode;

      showCustomSnackBar('You got ${_couponCodeAmount.toString()} discount',context, isToaster: true, isError: false);
    }else if(response.response.statusCode == 202){
      _couponController.clear();
      Map  map = response.response.data;
      String message = map['message'];
      showCustomSnackBar(message,context, isToaster: true);
    }
    else {
      _couponController.clear();
      ApiChecker.checkApi(context, response);
    }
    notifyListeners();
  }

  void oneClick(){
    _singleClick = true;
    notifyListeners();
  }

  void clearCardForCancel(){
    _couponCodeAmount = 0;
    _extraDiscountAmount = 0;
    notifyListeners();

  }

  Future<ApiResponse> placeOrder(BuildContext context, PlaceOrderBody placeOrderBody) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse response = await cartRepo.placeOrder(placeOrderBody);
    if(response.response.statusCode == 200){
      _isLoading = false;
      _couponCodeAmount = 0;
      _productDiscount = 0;
      _customerBalance = 0;
      _customerWalletController.clear();
      Provider.of<OrderProvider>(context, listen: false).getOrderList(context, 1,'all');
      showCustomSnackBar(getTranslated('order_placed_successfully', context), context, isToaster: true, isError: false);
      _extraDiscountAmount = 0;
      _amount = 0;
      _collectedCashController.clear();
      _customerCartList.removeAt(_customerIndex);
      _customerIds.removeAt(_customerIndex);

      if(_customerIds.isNotEmpty) {
        _amount = 0;
        setCustomerIndex(0, false);
        // Get.find<CartProvider>().searchCustomerController.text = 'walking customer';
        setCustomerInfo(_customerCartList[_customerIndex].userId, _customerCartList[_customerIndex].customerName, '', true);
      }
      Navigator.push(context, MaterialPageRoute(builder: (_)=> InVoiceScreen(orderId: response.response.data['order_id'])));

    }else{
      ApiChecker.checkApi(context, response);
    }
    notifyListeners();
    return response;
  }




  Future<void> scanProductBarCode(BuildContext context) async{
    String scannedProductBarCode;
    try{
      scannedProductBarCode = await FlutterBarcodeScanner.scanBarcode('#003E47', 'cancel', false, ScanMode.BARCODE);
    }
    on PlatformException{}
    getProductFromScan(context, scannedProductBarCode);
  }




  Future<void> getProductFromScan(BuildContext context, String productCode) async {
    _isLoading = true;
    ApiResponse response = await cartRepo.getProductFromScan(productCode);
    if(response.response.statusCode == 200) {

      _scanProduct = Product.fromJson(response.response.data);
      Provider.of<ProductProvider>(context, listen: false).initData(_scanProduct,1, context);
      if(scanProduct.variation.isNotEmpty){

        showModalBottomSheet(context: context, isScrollControlled: true,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
            builder: (con) => CartBottomSheet(product: _scanProduct, callback: (){
              showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);},));

      }else{

        CartModel cartModel = CartModel(_scanProduct.unitPrice, _scanProduct.discount, 1, _scanProduct.tax,null,null, _scanProduct, _scanProduct.taxModel);
        addToCart(context, cartModel);
      }

      _isLoading = false;
    }else {
      ApiChecker.checkApi(context, response);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setCustomerIndex(int index, bool notify) async {
    _amount = 0;
    _customerIndex = index;
    if(_customerCartList.isNotEmpty) {
      for(int i =0; i< _customerCartList[_customerIndex].cart.length; i++){
        _amount = _amount + (_customerCartList[_customerIndex].cart[i].price * _customerCartList[_customerIndex].cart[i].quantity);
      }
    }

    if(notify) {
      notifyListeners();
    }
  }


  int _reviewCustomerIndex = 0;
  int get reviewCustomerIndex => _reviewCustomerIndex;
  int _selectedCustomerIdForReviewFilter = 0;
  int get selectedCustomerIdForReviewFilter => _selectedCustomerIdForReviewFilter;

  List<int> _reviewCustomerIds = [];
  List<int> get reviewCustomerIds => _reviewCustomerIds;


  void setReviewCustomerIndex(int index,int customerId, bool notify) {
    _reviewCustomerIndex = index;
    _selectedCustomerIdForReviewFilter = customerId;
    if(notify) {
      notifyListeners();
    }
  }


  Future<void> getCustomerList(BuildContext context) async {
    _reviewCustomerIndex = 0;
    _reviewCustomerIds = [];
    _searchedCustomerList = [];
    _isGetting = true;
    ApiResponse response = await cartRepo.getCustomerList();
    if(response.response.statusCode == 200) {
      _searchedCustomerList = [];
      _searchedCustomerList.addAll(CustomerModel.fromJson(response.response.data).customers);
      _isGetting = false;
      _isFirst = false;
      if(_searchedCustomerList.length != 0){
        for(int index = 0; index < _searchedCustomerList.length; index++) {
          _reviewCustomerIds.add(_searchedCustomerList[index].id);
        }
        _reviewCustomerIndex = _reviewCustomerIds[0];
      }
    }else {
      ApiChecker.checkApi(context, response);
    }
    _isGetting = false;
    notifyListeners();
  }

  bool _showDialog = false;
  bool get showHideDialog=> _showDialog;

  void shoHideDialog(bool showDialog){
     _showDialog = showDialog;

    notifyListeners();
  }


  Future<void> searchCustomer(BuildContext context,String searchName) async {
    shoHideDialog(true);
    _searchedCustomerList = [];
    _isGetting = true;
    ApiResponse response = await cartRepo.customerSearch(searchName);
    if(response.response.statusCode == 200) {
      _searchedCustomerList = [];
      _searchedCustomerList.addAll(CustomerModel.fromJson(response.response.data).customers);
      _isGetting = false;
      _isFirst = false;
    }else {
      ApiChecker.checkApi(context, response);
    }
    _isGetting = false;
    notifyListeners();

  }

  void setCustomerInfo(int id, String name, String phone,  bool notify) {
    _customerId = id;
    _customerSelectedName = name;
    _customerSelectedMobile  = phone;
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> addNewCustomer(BuildContext context,CustomerBody customerBody) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await cartRepo.addNewCustomer(customerBody);
    if(response.response.statusCode == 200) {
      _isLoading = false;
      Navigator.pop(context);
      Map map = response.response.data;
      String message = map['message'];
      showCustomSnackBar(message, context, isError: false);
    }
    else {
      _isLoading = false;
      ApiChecker.checkApi(context, response);
    }
    notifyListeners();
  }

}