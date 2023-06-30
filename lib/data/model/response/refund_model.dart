import 'package:sixvalley_vendor_app/data/model/response/chat_model.dart';

class RefundModel {
  int id;
  int orderDetailsId;
  int customerId;
  String status;
  double amount;
  int productId;
  int orderId;
  String refundReason;
  List<String> images;
  String createdAt;
  String updatedAt;
  Product product;
  Customer customer;
  String approvedNote;
  String rejectedNote;
  String paymentInfo;
  String changeBy;
  OrderDetails orderDetails;
  Order order;


  RefundModel(
      {this.id,
        this.orderDetailsId,
        this.customerId,
        this.status,
        this.amount,
        this.productId,
        this.orderId,
        this.refundReason,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.customer,
        this.approvedNote,
        this.rejectedNote,
        this.paymentInfo,
        this.changeBy,
        this.orderDetails,
        this.order
      });

  RefundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDetailsId = json['order_details_id'];
    customerId = json['customer_id'];
    status = json['status'];
    amount = json['amount'].toDouble();
    productId = json['product_id'];
    orderId = json['order_id'];
    refundReason = json['refund_reason'];
    if(json['images']!=null){
      images = json['images'].cast<String>();
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    approvedNote = json['approved_note'];
    rejectedNote = json['rejected_note'];
    paymentInfo = json['payment_info'];
    changeBy = json['change_by'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    orderDetails = json['order_details'] != null ? new OrderDetails.fromJson(json['order_details']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_details_id'] = this.orderDetailsId;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['refund_reason'] = this.refundReason;
    data['images'] = this.images;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['approved_note'] = this.approvedNote;
    data['rejected_note'] = this.rejectedNote;
    data['payment_info'] = this.paymentInfo;
    data['change_by'] = this.changeBy;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }

    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String addedBy;
  int userId;
  String name;
  String slug;
  String unit;
  int refundable;
  String thumbnail;
  int variantProduct;
  String attributes;
  String choiceOptions;
  String variation;
  double unitPrice;
  double discount;
  String discountType;


  Product(
      {this.id,
        this.addedBy,
        this.userId,
        this.name,
        this.slug,
        this.unit,
        this.refundable,
        this.thumbnail,
        this.variantProduct,
        this.attributes,
        this.choiceOptions,
        this.variation,
        this.unitPrice,
        this.discount,
        this.discountType,
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    unit = json['unit'];
    refundable = json['refundable'];
    thumbnail = json['thumbnail'];
    if(json['variant_product']!=null){
      variantProduct = int.parse(json['variant_product'].toString());
    }else{
      variantProduct = 0;
    }

    attributes = json['attributes'];
    choiceOptions = json['choice_options'];
    variation = json['variation'];
    unitPrice = json['unit_price'].toDouble();
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['unit'] = this.unit;
    data['refundable'] = this.refundable;
    data['thumbnail'] = this.thumbnail;
    data['variant_product'] = this.variantProduct;
    data['attributes'] = this.attributes;
    data['choice_options'] = this.choiceOptions;
    data['variation'] = this.variation;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['unit_price'] = this.unitPrice;

    return data;
  }
}

class OrderDetails {
  String variant;


  OrderDetails(
      {
        this.variant,
       });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    if(json['variant']!=null){
      variant = json['variant'];
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['variant'] = this.variant;

    return data;
  }
}

class Order {
  int id;
  String paymentMethod;

  Order({this.id, this.paymentMethod});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}