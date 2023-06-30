class ChatModel {
  int totalSize;
  String limit;
  String offset;
  List<Chat> chat;

  ChatModel({this.totalSize, this.limit, this.offset, this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.chat != null) {
      data['chat'] = this.chat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  int id;
  int userId;
  int deliveryManId;
  String message;
  int sentByCustomer;
  int sentByDeliveryMan;
  int seenBySeller;
  String createdAt;
  String updatedAt;
  DeliveryMan deliveryMan;
  Customer customer;

  Chat(
      {this.id,
        this.userId,
        this.deliveryManId,
        this.message,
        this.sentByCustomer,
        this.sentByDeliveryMan,
        this.seenBySeller,
        this.createdAt,
        this.updatedAt,
        this.deliveryMan,
        this.customer,
      });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if(json['delivery_man_id'] != null){
      deliveryManId = int.parse(json['delivery_man_id'].toString());
    }

    message = json['message'];
    sentByCustomer = json['sent_by_customer'];
    sentByDeliveryMan = json['sent_by_delivery_man'];
    seenBySeller = json['seen_by_seller'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryMan = json['delivery_man'] != null ? new DeliveryMan.fromJson(json['delivery_man']) : null;
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['delivery_man_id'] = this.deliveryManId;
    data['message'] = this.message;
    data['sent_by_customer'] = this.sentByCustomer;
    data['sent_by_delivery_man'] = this.sentByDeliveryMan;
    data['seen_by_seller'] = this.seenBySeller;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

class DeliveryMan {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String image;


  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
      });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    return data;
  }
}

class Customer {
  int id;
  String fName;
  String lName;
  String phone;
  String image;
  String email;


  Customer(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
        });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email'] = this.email;
    return data;
  }
}