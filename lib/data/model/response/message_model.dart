import 'package:sixvalley_vendor_app/data/model/response/chat_model.dart';

class MessageModel {
  int totalSize;
  String limit;
  String offset;
  List<Message> message;

  MessageModel({this.totalSize, this.limit, this.offset, this.message});

  MessageModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.message != null) {
      data['message'] = this.message.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int id;
  int userId;
  int deliveryManId;
  String message;
  int sentByCustomer;
  int sentByDeliveryMan;
  int sentBySeller;
  int seenBySeller;
  String createdAt;
  String updatedAt;
  Customer customer;
  DeliveryMan deliveryMan;

  Message(
      {this.id,
        this.userId,
        this.deliveryManId,
        this.message,
        this.sentByCustomer,
        this.sentByDeliveryMan,
        this.sentBySeller,
        this.seenBySeller,
        this.createdAt,
        this.updatedAt,
        this.customer,
      this.deliveryMan});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if(json['delivery_man_id'] != null){
      deliveryManId = int.parse(json['delivery_man_id'].toString());
    }

    message = json['message'];
    sentByCustomer = json['sent_by_customer'];
    if(json['sent_by_delivery_man'] != null){
      sentByDeliveryMan = int.parse(json['sent_by_delivery_man'].toString());
    }

    sentBySeller = json['sent_by_seller'];
    seenBySeller = json['seen_by_seller'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    deliveryMan = json['delivery_man'] != null ? new DeliveryMan.fromJson(json['delivery_man']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['delivery_man_id'] = this.deliveryManId;
    data['message'] = this.message;
    data['sent_by_customer'] = this.sentByCustomer;
    data['sent_by_delivery_man'] = this.sentByDeliveryMan;
    data['sent_by_seller'] = this.sentBySeller;
    data['seen_by_seller'] = this.seenBySeller;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.toJson();
    }
    return data;
  }
}


