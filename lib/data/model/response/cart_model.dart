
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class CartModel {
  double _price;
  double _discountAmount;
  int _quantity;
  double _taxAmount;
  String _variant;
  Variation _variation;
  Product _product;
  String _taxModel;

  CartModel(
      double price,
      double discountAmount,
      int quantity,
      double taxAmount,
      String variant,
      Variation variation,
      Product product,
      String taxModel
      ) {
    this._price = price;
    this._discountAmount = discountAmount;
    this._quantity = quantity;
    this._taxAmount = taxAmount;
    this._variation = variation;
    this._variant = variant;
    this._product = product;
    this._taxModel = taxModel;
  }

  double get price => _price;
  double get discountAmount => _discountAmount;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int qty) => _quantity = qty;
  double get taxAmount => _taxAmount;
  Product get product => _product;
  Variation get variation => _variation;
  String get variant => _variant;
  String get taxModel=> _taxModel;

  CartModel.fromJson(Map<String, dynamic> json) {
    _price = json['price'].toDouble();
    _discountAmount = json['discount_amount'].toDouble();
    _quantity = json['quantity'];
    _taxAmount = json['tax_amount'].toDouble();
    _variation = json['variation'] != null ? Variation.fromJson(json['variation']) : null;
    _variant = json['variant'];
    if (json['product'] != null) {
      _product = Product.fromJson(json['product']);
    }
    _taxModel = json['tax_model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this._price;
    data['discount_amount'] = this._discountAmount;
    data['quantity'] = this._quantity;
    data['tax_amount'] = this._taxAmount;
    data['variation'] = this._variation;
    data['variant'] = this._variant;
    data['product'] = this._product.toJson();
    data['tax_model'] = this._taxModel;
    return data;
  }
}


