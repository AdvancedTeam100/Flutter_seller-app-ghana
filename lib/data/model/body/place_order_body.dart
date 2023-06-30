import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class PlaceOrderBody {
  List<Cart> _cart;
  double _couponDiscountAmount;
  double _orderAmount;
  String _couponCode;
  double _couponAmount;
  int _userId;
  double _extraDiscount;
  String _extraDiscountType;
  String _paymentMethod;




  PlaceOrderBody(
      {@required List<Cart> cart,
        double couponDiscountAmount,
        String couponCode,
        double couponAmount,
        double orderAmount,
        int userId,
        double extraDiscount,
        String extraDiscountType,
        String paymentMethod,


       }) {
    this._cart = cart;
    this._couponDiscountAmount = couponDiscountAmount;
    this._couponCode = couponCode;
    this._couponAmount = couponAmount;
    this._orderAmount = orderAmount;
    this._userId = userId;
    this._extraDiscount = extraDiscount;
    this._extraDiscountType = extraDiscountType;
    this._paymentMethod = paymentMethod;

  }

  List<Cart> get cart => _cart;
  double get couponDiscountAmount => _couponDiscountAmount;
  String get couponCode => _couponCode;
  double get couponAmount => _couponAmount;
  double get orderAmount => _orderAmount;
  int get userId => _userId;
  double get extraDiscount => _extraDiscount;
  String get extraDiscountType => _extraDiscountType;
  String get paymentMethod => _paymentMethod;


  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart.add(new Cart.fromJson(v));
      });
    }
    _couponDiscountAmount = json['coupon_discount'];
    _couponCode = json['coupon_code'];
    _couponAmount = json['coupon_discount_amount'];
    _orderAmount = json['order_amount'];
    _userId = json['customer_id'];
    _extraDiscount = json['extra_discount'];
    _extraDiscountType = json ['extra_discount_type'];
    _paymentMethod = json ['payment_method'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._cart != null) {
      data['cart'] = this._cart.map((v) => v.toJson()).toList();
    }
    data['coupon_discount'] = this._couponDiscountAmount;
    data['order_amount'] = this._orderAmount;
    data['coupon_code'] = this._couponCode;
    data['coupon_discount_amount'] = this._couponAmount;
    data['customer_id'] = this._userId;
    data['extra_discount'] = this._extraDiscount;
    data['extra_discount_type'] = this._extraDiscountType;
    data['payment_method'] = this._paymentMethod;

    return data;
  }
}

class Cart {
  String _productId;
  String _price;
  double _discountAmount;
  int _quantity;
  String _variant;
  List<Variation> _variation;




  Cart(
      String productId,
      String price,
      double discountAmount,
      int quantity,
      String variant,
      List<Variation> variation


      ) {
    this._productId = productId;
    this._price = price;
    this._discountAmount = discountAmount;
    this._quantity = quantity;
    this._variant = variant;
    if (variation != null) {
      this._variation = variation;
    }



  }

  String get productId => _productId;
  String get price => _price;
  double get discountAmount => _discountAmount;
  int get quantity => _quantity;
  String get variant => _variant;
  List<Variation> get variation => _variation;



  Cart.fromJson(Map<String, dynamic> json) {
    _productId = json['id'];
    _price = json['price'];
    _discountAmount = json['discount'];
    _quantity = json['quantity'];
    _variant = json['variant'];
    if (json['variation'] != null) {
      _variation = <Variation>[];
      json['variation'].forEach((v) {
        _variation.add(new Variation.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._productId;
    data['price'] = this._price;
    data['discount'] = this._discountAmount;
    data['quantity'] = this._quantity;
    data['variant'] = this._variant;
    if (this._variation != null) {
      data['variation'] = this._variation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
