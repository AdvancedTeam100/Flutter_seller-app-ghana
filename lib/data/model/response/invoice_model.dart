class InvoiceModel {
  double orderAmount;
  String createdAt;
  double discountAmount;
  double extraDiscount;
  String paymentMethod;
  List<Details> details;

  InvoiceModel(
      {
        this.orderAmount,
        this.createdAt,
        this.extraDiscount,
        this.paymentMethod,
        this.details,
        });

  InvoiceModel.fromJson(Map<String, dynamic> json) {


    if(json['order_amount'] != null){
      try{
        orderAmount = json['order_amount'].toDouble();
      }catch(e){
        orderAmount = double.parse(json['order_amount'].toString());
      }

    }
    createdAt = json['created_at'];
    paymentMethod = json['payment_method'];

    if(json['discount_amount'] != null){
      try{
        discountAmount = json['discount_amount'].toDouble();
      }catch(e){
        discountAmount = double.parse(json['discount_amount'].toString());
      }
    }
    if(json['extra_discount'] != null){
      try{
        extraDiscount = json['extra_discount'].toDouble();
      }catch(e){
        extraDiscount = double.parse(json['extra_discount'].toString());
      }
    }

    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_amount'] = this.orderAmount;
    data['created_at'] = this.createdAt;
    data['discount_amount'] = this.discountAmount;
    data['extra_discount'] = this.extraDiscount;
    data['payment_method'] = this.paymentMethod;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int id;
  ProductDetails productDetails;
  int qty;
  double price;
  double tax;
  double discount;
  String discountType;
  String variant;


  Details(
      {this.id,
        this.productDetails,
        this.qty,
        this.price,
        this.tax,
        this.discount,
        this.discountType,
        this.variant,
        });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    qty = json['qty'];
    if(json['price'] != null){
      try{
        price = json['price'].toDouble();
      }catch(e){
        price = double.parse(json['price'].toString());
      }
    }

    if(json['tax'] != null){
      try{
        tax = json['tax'].toDouble();
      }catch(e){
        tax = double.parse(json['tax'].toString());
      }
    }

    if(json['discount'] != null){
      try{
        discount = json['discount'].toDouble();
      }catch(e){
        discount = double.parse(json['discount'].toString());
      }
    }
    discountType = json['discount_type'];

    variant = json['variant'];




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails.toJson();
    }
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['variant'] = this.variant;
    return data;
  }
}

class ProductDetails {

  String name;
  String taxModel;
  double discount;
  String discountType;

  ProductDetails(
      {
        this.name,
        this.taxModel,
        this.discount,
        this.discountType

        });

  ProductDetails.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    taxModel = json['tax_model'];
    discount = json['discount'] != null?
    json['discount'].toDouble() : 0;
    discountType = json['discount_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['discount'] = this.taxModel;
    data['tax_model'] = this.taxModel;

    return data;
  }
}

