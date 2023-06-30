import 'dart:convert';

class TopDeliveryMan {
  int totalSize;
  String limit;
  String offset;
  List<DeliveryMan> deliveryMan;

  TopDeliveryMan({this.totalSize, this.limit, this.offset, this.deliveryMan});

  TopDeliveryMan.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['delivery_man'] != null) {
      deliveryMan = <DeliveryMan>[];
      json['delivery_man'].forEach((v) {
        deliveryMan.add(new DeliveryMan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryMan {
  int id;
  String fName;
  String lName;
  String address;
  String countryCode;
  String phone;
  String email;
  String identityNumber;
  String identityType;
  List<dynamic> identityImage;
  String image;
  int isOnline;
  List<Rating> rating;
  List<Orders> orders;

  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.address,
        this.countryCode,
        this.phone,
        this.email,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.image,
        this.isOnline,
        this.rating,
        this.orders});

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    address = json['address'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = jsonDecode(json['identity_image']);
    image = json['image'];
    isOnline = int.parse(json['is_online'].toString());
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating.add(new Rating.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['address'] = this.address;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['is_online'] = this.isOnline;
    if (this.rating != null) {
      data['rating'] = this.rating.map((v) => v.toJson()).toList();
    }
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  String average;
  int deliveryManId;

  Rating({this.average, this.deliveryManId});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    deliveryManId = json['delivery_man_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this.average;
    data['delivery_man_id'] = this.deliveryManId;
    return data;
  }
}

class Orders {
  int deliveryManId;
  int count;

  Orders({this.deliveryManId, this.count});

  Orders.fromJson(Map<String, dynamic> json) {
    deliveryManId = json['delivery_man_id'];
    count = json['count'] != null ? int.parse(json['count'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_man_id'] = this.deliveryManId;
    data['count'] = this.count;
    return data;
  }
}
