class RefundDetailsModel {
  double productPrice;
  int quntity;
  double productTotalDiscount;
  double productTotalTax;
  double subtotal;
  double couponDiscount;
  double refundAmount;
  List<RefundRequest> refundRequest;
  DeliverymanDetails deliverymanDetails;

  RefundDetailsModel(
      {this.productPrice,
        this.quntity,
        this.productTotalDiscount,
        this.productTotalTax,
        this.subtotal,
        this.couponDiscount,
        this.refundAmount,
        this.refundRequest,
        this.deliverymanDetails
      });

  RefundDetailsModel.fromJson(Map<String, dynamic> json) {
    productPrice = json['product_price'].toDouble();
    quntity = json['quntity'];
    productTotalDiscount = json['product_total_discount'].toDouble();
    productTotalTax = json['product_total_tax'].toDouble();
    subtotal = json['subtotal'].toDouble();
    couponDiscount = json['coupon_discount'].toDouble();
    refundAmount = json['refund_amount'].toDouble();
    if (json['refund_request'] != null) {
      refundRequest = <RefundRequest>[];
      json['refund_request'].forEach((v) {
        refundRequest.add(new RefundRequest.fromJson(v));
      });
    }
    deliverymanDetails = json['deliveryman_details'] != null
        ? new DeliverymanDetails.fromJson(json['deliveryman_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_price'] = this.productPrice;
    data['quntity'] = this.quntity;
    data['product_total_discount'] = this.productTotalDiscount;
    data['product_total_tax'] = this.productTotalTax;
    data['subtotal'] = this.subtotal;
    data['coupon_discount'] = this.couponDiscount;
    data['refund_amount'] = this.refundAmount;
    if (this.refundRequest != null) {
      data['refund_request'] =
          this.refundRequest.map((v) => v.toJson()).toList();
    }
    if (this.deliverymanDetails != null) {
      data['deliveryman_details'] = this.deliverymanDetails.toJson();
    }
    return data;
  }
}

class RefundRequest {
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
  String approvedNote;
  String rejectedNote;
  String paymentInfo;
  String changeBy;
  List<RefundStatus> refundStatus;

  RefundRequest(
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
        this.approvedNote,
        this.rejectedNote,
        this.paymentInfo,
        this.changeBy,
        this.refundStatus});

  RefundRequest.fromJson(Map<String, dynamic> json) {
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
    approvedNote = json['approved_note'];
    rejectedNote = json['rejected_note'];
    paymentInfo = json['payment_info'];
    changeBy = json['change_by'];
    if (json['refund_status'] != null) {
      refundStatus = <RefundStatus>[];
      json['refund_status'].forEach((v) {
        refundStatus.add(new RefundStatus.fromJson(v));
      });
    }
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
    data['approved_note'] = this.approvedNote;
    data['rejected_note'] = this.rejectedNote;
    data['payment_info'] = this.paymentInfo;
    data['change_by'] = this.changeBy;
    if (this.refundStatus != null) {
      data['refund_status'] =
          this.refundStatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefundStatus {
  int id;
  int refundRequestId;
  String changeBy;
  int changeById;
  String status;
  String message;
  String createdAt;
  String updatedAt;

  RefundStatus(
      {this.id,
        this.refundRequestId,
        this.changeBy,
        this.changeById,
        this.status,
        this.message,
        this.createdAt,
        this.updatedAt});

  RefundStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refundRequestId = json['refund_request_id'];
    changeBy = json['change_by'];
    if(json['change_by_id']!=null)
      {
        try{
          changeById = json['change_by_id'];
        }catch(e){
          changeById = int.parse(json['change_by_id']);
        }
      }

    status = json['status'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['refund_request_id'] = this.refundRequestId;
    data['change_by'] = this.changeBy;
    data['change_by_id'] = this.changeById;
    data['status'] = this.status;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DeliverymanDetails {
  int id;
  int sellerId;
  String fName;
  String lName;
  String phone;
  String email;
  String identityNumber;
  String identityType;
  String identityImage;
  String image;
  int isActive;
  String createdAt;
  String updatedAt;
  String fcmToken;

  DeliverymanDetails(
      {this.id,
        this.sellerId,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.image,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.fcmToken});

  DeliverymanDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}