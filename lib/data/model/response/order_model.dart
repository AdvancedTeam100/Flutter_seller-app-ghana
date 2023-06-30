
import 'dart:convert';

import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';


class OrderModel {
  int totalSize;
  int limit;
  int offset;
  List<Order> orders;

  OrderModel({this.totalSize, this.limit, this.offset, this.orders});

  OrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Order {
  int _id;
  int _customerId;
  String _customerType;
  String _paymentStatus;
  String _orderStatus;
  String _paymentMethod;
  String _transactionRef;
  double _orderAmount;
  int _shippingAddress;
  String _shippingAddressData;
  int _billingAddress;
  BillingAddressData _billingAddressData;
  String _createdAt;
  String _updatedAt;
  double _discountAmount;
  double _shippingCost;
  String _discountType;
  Customer _customer;
  int _deliveryManId;
  String _orderNote;
  String _orderType;
  Shipping _shipping;
  double _extraDiscount;
  String _extraDiscountType;
  String _deliveryType;
  String _thirdPartyServiceName;
  String _thirdPartyTrackingId;
  double _deliverymanCharge;
  String _expectedDeliveryDate;
  DeliveryMan deliveryMan;

  Order(
      {int id,
        int customerId,
        String customerType,
        String paymentStatus,
        String orderStatus,
        String paymentMethod,
        String transactionRef,
        double orderAmount,
        int shippingAddress,
        String shippingAddressData,
        int billingAddress,
        BillingAddressData billingAddressData,
        double shippingCost,
        String createdAt,
        String updatedAt,
        double discountAmount,
        String discountType,
        Customer customer,
        int deliveryManId,
        String orderNote,
        String orderType,
        Shipping shipping,
        double extraDiscount,
        String extraDiscountType,
        String deliveryType,
        String thirdPartyServiceNam,
        String thirdPartyTrackingId,
        double deliverymanCharge,
        String expectedDeliveryDate,
        DeliveryMan deliveryMan,
      }) {
    this._id = id;
    this._customerId = customerId;
    this._customerType = customerType;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._paymentMethod = paymentMethod;
    this._transactionRef = transactionRef;
    this._orderAmount = orderAmount;
    this._shippingAddress = shippingAddress;
    this._shippingAddressData = shippingAddressData;
    this._billingAddress = billingAddress;
    this._billingAddressData = billingAddressData;
    this._shippingCost = shippingCost;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._discountAmount = discountAmount;
    this._discountType = discountType;
    this._customer = customer;
    this._deliveryManId = deliveryManId;
    this._orderNote = orderNote;
    this._orderType = orderType;
    if (shipping != null) {
      this._shipping = shipping;
    }
    if (extraDiscount != null) {
      this._extraDiscount = extraDiscount;
    }
    if (extraDiscountType != null) {
      this._extraDiscountType = extraDiscountType;
    }
    if (deliveryType != null) {
      this._deliveryType = deliveryType;
    }
    if (thirdPartyServiceNam != null) {
      this._thirdPartyServiceName = thirdPartyServiceNam;
    }
    if (thirdPartyTrackingId != null) {
      this._thirdPartyTrackingId = thirdPartyTrackingId;
    }
    this._deliverymanCharge = deliverymanCharge;
    this._expectedDeliveryDate = expectedDeliveryDate;
    if (deliveryMan != null) {
      this.deliveryMan = deliveryMan;
    }


  }

  // ignore: unnecessary_getters_setters
  int get id => _id;
  // ignore: unnecessary_getters_setters
  set id(int id) => _id = id;
  int get customerId => _customerId;
  String get customerType => _customerType;
  String get paymentStatus => _paymentStatus;
  // ignore: unnecessary_getters_setters
  String get orderStatus => _orderStatus;
  // ignore: unnecessary_getters_setters
  set orderStatus(String orderStatus) => _orderStatus = orderStatus;
  String get paymentMethod => _paymentMethod;
  String get transactionRef => _transactionRef;
  double get orderAmount => _orderAmount;
  double get shippingCost => _shippingCost;
  int get shippingAddress => _shippingAddress;
  String get shippingAddressData => _shippingAddressData;
  int get billingAddress => _billingAddress;
  BillingAddressData get billingAddressData => _billingAddressData;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  double get discountAmount => _discountAmount;
  String get discountType => _discountType;
  Customer get customer => _customer;
  int get deliveryManId =>_deliveryManId;
  String get orderNote => _orderNote;
  String get orderType => _orderType;
  Shipping get shipping => _shipping;
  double get extraDiscount => _extraDiscount;
  String get extraDiscountType => _extraDiscountType;
  String get deliveryType => _deliveryType;
  String get  thirdPartyServiceName => _thirdPartyServiceName;
  String get  thirdPartyTrackingId => _thirdPartyTrackingId;
  double get deliverymanCharge => _deliverymanCharge;
  String get expectedDeliveryDate => _expectedDeliveryDate;


  Order.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _customerType = json['customer_type'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _paymentMethod = json['payment_method'];
    _transactionRef = json['transaction_ref'];
    if(json['order_amount'] != null){
      try{
        _orderAmount = json['order_amount'].toDouble();
      }catch(e){
        _orderAmount = double.parse(json['order_amount'].toString());
      }
    }
    if(json['shipping_cost'] != null){
      _shippingCost = json['shipping_cost'].toDouble();
    }

    _shippingAddress = json['shipping_address'];
    _shippingAddressData = json['shipping_address_data'];
    _billingAddress = json['billing_address'];
    if(json['billing_address_data'] != null){
      try{
        _billingAddressData =  BillingAddressData.fromJson(json['billing_address_data']);
      }catch(e){
        _billingAddressData =  BillingAddressData.fromJson(jsonDecode(json['billing_address_data']));
      }
    }

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if(json['delivery_man_id'] != null){
      _deliveryManId = json['delivery_man_id'];
    }

    if(json['discount_amount']!=null){
      _discountAmount = json['discount_amount'].toDouble();
    }

    _discountType = json['discount_type'];
    _customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    _orderNote = json['order_note'];
    _orderType = json['order_type'];
    _shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if(json['extra_discount'] != null){
      _extraDiscount = json['extra_discount'].toDouble();
    }

    _extraDiscountType = json['extra_discount_type'];
    if(json['delivery_type']!=null && json['delivery_type']!= ""){
      _deliveryType = json['delivery_type'];
    }
    if(json['delivery_service_name']!=null && json['delivery_service_name']!= ""){
      _thirdPartyServiceName = json['delivery_service_name'];
    }
    if(json['third_party_delivery_tracking_id']!=null && json['third_party_delivery_tracking_id']!= ""){
      _thirdPartyTrackingId = json['third_party_delivery_tracking_id'];
    }
    if(json['deliveryman_charge'] != null){
      try{
        _deliverymanCharge = json['deliveryman_charge'].toDouble();
      }catch(e){
        _deliverymanCharge = double.parse(json['deliveryman_charge'].toString());
      }
    }

    _expectedDeliveryDate = json['expected_delivery_date'];
    deliveryMan = json['delivery_man'] != null
        ? new DeliveryMan.fromJson(json['delivery_man'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['customer_id'] = this._customerId;
    data['customer_type'] = this._customerType;
    data['payment_status'] = this._paymentStatus;
    data['order_status'] = this._orderStatus;
    data['payment_method'] = this._paymentMethod;
    data['transaction_ref'] = this._transactionRef;
    data['order_amount'] = this._orderAmount;
    data['shipping_address'] = this._shippingAddress;
    data['shipping_address_data'] = this.shippingAddressData;
    data['billing_address'] = this._billingAddress;
    if (this.billingAddressData != null) {
      data['billing_address_data'] = this.billingAddressData.toJson();
    }
    data['shipping_cost'] = this._shippingCost;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['delivery_man_id'] = this._deliveryManId;
    data['discount_amount'] = this._discountAmount;
    data['discount_type'] = this._discountType;
    if (this._customer != null) {
      data['customer'] = this._customer.toJson();
    }
    data['order_note'] = this._orderNote;
    data['order_type'] = this._orderType;
    if (this._shipping != null) {
      data['shipping'] = this._shipping.toJson();
    }
    data['extra_discount'] = this._extraDiscount;
    data['extra_discount_type'] = this._extraDiscountType;
    data['delivery_type'] = this._deliveryType;
    data['delivery_type'] = this._deliveryType;
    data['delivery_service_name'] = this._thirdPartyServiceName;
    data['third_party_delivery_tracking_id'] = this._thirdPartyTrackingId;
    data['deliveryman_charge'] = this._deliverymanCharge;
    data['expected_delivery_date'] = this._expectedDeliveryDate;
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.toJson();
    }
    return data;
  }
}

class Customer {
  int _id;
  String _name;
  String _fName;
  String _lName;
  String _phone;
  String _image;
  String _email;
  String _emailVerifiedAt;
  String _createdAt;
  String _updatedAt;
  String _streetAddress;
  String _country;
  String _city;
  String _zip;
  String _houseNo;
  String _apartmentNo;
  String _cmFirebaseToken;
  DeliveryMan _deliveryMan;

  Customer(
      {int id,
        String name,
        String fName,
        String lName,
        String phone,
        String image,
        String email,
        String emailVerifiedAt,
        String createdAt,
        String updatedAt,
        String streetAddress,
        String country,
        String city,
        String zip,
        String houseNo,
        String apartmentNo,
        String cmFirebaseToken,
        DeliveryMan deliveryMan,
      }) {
    this._id = id;
    this._name = name;
    this._fName = fName;
    this._lName = lName;
    this._phone = phone;
    this._image = image;
    this._email = email;
    this._emailVerifiedAt = emailVerifiedAt;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._streetAddress = streetAddress;
    this._country = country;
    this._city = city;
    this._zip = zip;
    this._houseNo = houseNo;
    this._apartmentNo = apartmentNo;
    this._cmFirebaseToken = cmFirebaseToken;
    if (deliveryMan != null) {
      this._deliveryMan = deliveryMan;
    }
  }

  int get id => _id;
  String get name => _name;
  String get fName => _fName;
  String get lName => _lName;
  String get phone => _phone;
  String get image => _image;
  String get email => _email;
  String get emailVerifiedAt => _emailVerifiedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get streetAddress => _streetAddress;
  String get country => _country;
  String get city => _city;
  String get zip => _zip;
  String get houseNo => _houseNo;
  String get apartmentNo => _apartmentNo;
  String get cmFirebaseToken => _cmFirebaseToken;
  DeliveryMan get deliveryMan => _deliveryMan;

  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    if(json['f_name']!=null){
      _fName = json['f_name'];
    }

    if(json['l_name']!=null){
      _lName = json['l_name'];
    }

    _phone = json['phone'];
    _image = json['image'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _streetAddress = json['street_address'];
    _country = json['country'];
    _city = json['city'];
    _zip = json['zip'];
    _houseNo = json['house_no'];
    _apartmentNo = json['apartment_no'];
    _cmFirebaseToken = json['cm_firebase_token'];
    _deliveryMan = json['delivery_man'] != null
        ? new DeliveryMan.fromJson(json['delivery_man'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['phone'] = this._phone;
    data['image'] = this._image;
    data['email'] = this._email;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['street_address'] = this._streetAddress;
    data['country'] = this._country;
    data['city'] = this._city;
    data['zip'] = this._zip;
    data['house_no'] = this._houseNo;
    data['apartment_no'] = this._apartmentNo;
    data['cm_firebase_token'] = this._cmFirebaseToken;
    if (this._deliveryMan != null) {
      data['delivery_man'] = this._deliveryMan.toJson();
    }
    return data;
  }
}


class BillingAddressData {
  int id;
  int customerId;
  String contactPersonName;
  String addressType;
  String address;
  String city;
  String zip;
  String phone;
  String createdAt;
  String updatedAt;
  String country;
  String latitude;
  String longitude;
  int isBilling;

  BillingAddressData(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling});

  BillingAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_billing'] = this.isBilling;
    return data;
  }
}

class Shipping {
  int _id;
  int _creatorId;
  String _creatorType;
  String _title;
  double _cost;
  String _duration;
  int _status;
  String _createdAt;
  String _updatedAt;

  Shipping(
      {int id,
        int creatorId,
        String creatorType,
        String title,
        double cost,
        String duration,
        int status,
        String createdAt,
        String updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (creatorId != null) {
      this._creatorId = creatorId;
    }
    if (creatorType != null) {
      this._creatorType = creatorType;
    }
    if (title != null) {
      this._title = title;
    }
    if (cost != null) {
      this._cost = cost;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (status != null) {
      this._status = status;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int get id => _id;
  int get creatorId => _creatorId;
  String get creatorType => _creatorType;
  String get title => _title;
  double get cost => _cost;
  String get duration => _duration;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;


  Shipping.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _creatorId = json['creator_id'];
    _creatorType = json['creator_type'];
    _title = json['title'];
    _cost = json['cost'].toDouble();
    _duration = json['duration'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['creator_id'] = this._creatorId;
    data['creator_type'] = this._creatorType;
    data['title'] = this._title;
    data['cost'] = this._cost;
    data['duration'] = this._duration;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

