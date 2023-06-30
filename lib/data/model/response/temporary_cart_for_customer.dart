import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';

class TemporaryCartListModel {
  List<CartModel> _cart;
  int _userId;
  String _customerName;
  int _userIndex;
  double _customerBalance;
  double _couponAmount;
  String couponCode;
  double _extraDiscount;



  TemporaryCartListModel(
      {List<CartModel> cart,
        int userId,
        String customerName,
        int userIndex,
        double customerBalance,
        double couponAmount,
        String couponCode,
        double extraDiscount,
      }) {
    this._cart = cart;
    this._userId = userId;
    this._customerName = customerName;
    this._userIndex = userIndex;
    this._customerBalance = customerBalance;
    this._couponAmount = couponAmount;
    this._extraDiscount = extraDiscount;

  }

  List<CartModel> get cart => _cart;
  int get userId => _userId;
  String get customerName => _customerName;
  int get userIndex => _userIndex;
  double get customerBalance => _customerBalance;
  // ignore: unnecessary_getters_setters
  double get couponAmount => _couponAmount;
  // ignore: unnecessary_getters_setters
  double get extraDiscount => _extraDiscount;


  set couponAmount(double value) {
    _couponAmount = value;
  }


  set extraDiscount(double value) {
    _extraDiscount = value;
  }

  TemporaryCartListModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart.add(new CartModel.fromJson(v));
      });
    }
    _userId = json['user_id'];
    _userIndex = json['user_index'];
    _customerName = json['customer_name'];
    _customerBalance = json['customer_balance'];
    couponCode = json['coupon_code'];
    _couponAmount = json['coupon_discount_amount'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._cart != null) {
      data['cart'] = this._cart.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this._userId;
    data['user_index'] = this._userIndex;
    data['customer_name'] = this._customerName;
    data['customer_balance'] = this._customerName;
    data['coupon_code'] = this.couponCode;
    data['coupon_discount_amount'] = this._couponAmount;


    return data;
  }


}

class Cart {
  String _productId;
  String _price;
  double _discountAmount;
  int _quantity;
  double _taxAmount;


  Cart(
      String productId,
      String price,
      double discountAmount,
      int quantity,
      double taxAmount,
      ) {
    this._productId = productId;
    this._price = price;
    this._discountAmount = discountAmount;
    this._quantity = quantity;
    this._taxAmount = taxAmount;

  }

  String get productId => _productId;
  String get price => _price;
  double get discountAmount => _discountAmount;
  int get quantity => _quantity;
  double get taxAmount => _taxAmount;


  Cart.fromJson(Map<String, dynamic> json) {
    _productId = json['id'];
    _price = json['price'];
    _discountAmount = json['discount'];
    _quantity = json['quantity'];
    _taxAmount = json['tax'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._productId;
    data['price'] = this._price;
    data['discount'] = this._discountAmount;
    data['quantity'] = this._quantity;
    data['tax'] = this._taxAmount;
    return data;
  }
}



