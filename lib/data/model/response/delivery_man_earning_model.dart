import 'package:sixvalley_vendor_app/data/model/response/delivery_man_detail_model.dart';

class DeliveryManEarning {
  int totalSize;
  String limit;
  String offset;
  double totalEarn;
  double withdrawableBalance;
  DeliveryMan deliveryMan;
  List<Earning> orders;

  DeliveryManEarning(
      {this.totalSize,
        this.limit,
        this.offset,
        this.totalEarn,
        this.withdrawableBalance,
        this.deliveryMan,
        this.orders});

  DeliveryManEarning.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if(json['total_earn'] != null){
      try{
        totalEarn = json['total_earn'].toDouble;
      }catch(e){
        totalEarn = double.parse(json['total_earn'].toString());
      }
    }

    if(json['withdrawable_balance'] != null){
      try{
        withdrawableBalance = json['withdrawable_balance'].toDouble();
      }catch(e){
        withdrawableBalance = double.parse(json['withdrawable_balance'].toString());
      }
    }


    deliveryMan = json['delivery_man'] != null ? new DeliveryMan.fromJson(json['delivery_man']) : null;
    if (json['orders'] != null) {
      orders = <Earning>[];
      json['orders'].forEach((v) {
        orders.add(new Earning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['total_earn'] = this.totalEarn;
    data['withdrawable_balance'] = this.withdrawableBalance;
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Earning {
  int id;
  double deliverymanCharge;
  String orderStatus;
  int deliveryManId;
  String updatedAt;

  Earning(
      {this.id,
        this.deliverymanCharge,
        this.orderStatus,
        this.deliveryManId,
        this.updatedAt});

  Earning.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['deliveryman_charge'] != null){
      try{
        deliverymanCharge = json['deliveryman_charge'].toDouble();
      }catch(e){
        deliverymanCharge = double.parse(json['deliveryman_charge'].toString());
      }

    }

    orderStatus = json['order_status'];
    deliveryManId = int.parse(json['delivery_man_id'].toString());
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deliveryman_charge'] = this.deliverymanCharge;
    data['order_status'] = this.orderStatus;
    data['delivery_man_id'] = this.deliveryManId;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
