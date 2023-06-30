

import 'package:sixvalley_vendor_app/data/model/response/delivery_man_detail_model.dart';

class DeliveryManWithdrawDetailModel {
  Details details;

  DeliveryManWithdrawDetailModel({this.details});

  DeliveryManWithdrawDetailModel.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Details {
  int id;
  double amount;
  String transactionNote;
  int approved;
  String createdAt;
  String updatedAt;
  DeliveryMan deliveryMen;

  Details(
      {this.id,
        this.amount,
        this.transactionNote,
        this.approved,
        this.createdAt,
        this.updatedAt,
        this.deliveryMen});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['amount'] != null){
      try{
        amount = json['amount'].toDouble();
      }catch(e){
        amount = double.parse(json['amount'].toString());
      }
    }

    transactionNote = json['transaction_note'];
    approved = json['approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryMen = json['delivery_men'] != null
        ? new DeliveryMan.fromJson(json['delivery_men'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['transaction_note'] = this.transactionNote;
    data['approved'] = this.approved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.deliveryMen != null) {
      data['delivery_men'] = this.deliveryMen.toJson();
    }
    return data;
  }
}


