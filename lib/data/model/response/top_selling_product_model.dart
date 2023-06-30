import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class TopSellingProductModel {
  int totalSize;
  String limit;
  String offset;
  List<Products> products;

  TopSellingProductModel(
      {this.totalSize, this.limit, this.offset, this.products});

  TopSellingProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int productId;
  String count;
  Product product;

  Products({this.productId, this.count, this.product});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json['count'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['count'] = this.count;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}


