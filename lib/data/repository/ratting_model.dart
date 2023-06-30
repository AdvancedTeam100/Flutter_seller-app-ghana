import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class RattingModel {
  int totalSize;
  String limit;
  String offset;
  List<Reviews> reviews;

  RattingModel({this.totalSize, this.limit, this.offset, this.reviews});

  RattingModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int id;
  int productId;
  int customerId;
  String comment;
  List<String> attachment;
  double rating;
  int status;
  int isSaved;
  String createdAt;
  String updatedAt;
  Product product;
  Customer customer;

  Reviews(
      {this.id,
        this.productId,
        this.customerId,
        this.comment,
        this.attachment,
        this.rating,
        this.status,
        this.isSaved,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.customer});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    attachment = json['attachment'].cast<String>();
    rating = json['rating'].toDouble();
    status = json['status'];
    isSaved = int.parse(json['is_saved'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['comment'] = this.comment;
    data['attachment'] = this.attachment;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['is_saved'] = this.isSaved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

