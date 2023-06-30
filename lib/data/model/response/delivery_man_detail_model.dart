class DeliveryManDetails {
  DeliveryMan deliveryMan;
  double withdrawbaleBalance;

  DeliveryManDetails({this.deliveryMan, this.withdrawbaleBalance});

  DeliveryManDetails.fromJson(Map<String, dynamic> json) {
    deliveryMan = json['delivery_man'] != null
        ? new DeliveryMan.fromJson(json['delivery_man'])
        : null;

    if(json['withdrawbale_balance'] != null){
      withdrawbaleBalance = json['withdrawbale_balance'].toDouble();
    }else{
      withdrawbaleBalance = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.toJson();
    }
    data['withdrawbale_balance'] = this.withdrawbaleBalance;
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
  String image;
  String bankName;
  String branch;
  String accountNo;
  String holderName;
  int isActive;
  int isOnline;
  Wallet wallet;



  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.address,
        this.countryCode,
        this.phone,
        this.email,
        this.image,
        this.bankName,
        this.branch,
        this.accountNo,
        this.holderName,
        this.isActive,
        this.isOnline,
        this.wallet,
        });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    address = json['address'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    isActive = json['is_active'];
    isOnline = json['is_online'];
    wallet = json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;



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
    data['image'] = this.image;
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    data['account_no'] = this.accountNo;
    data['holder_name'] = this.holderName;
    data['is_active'] = this.isActive;
    data['is_online'] = this.isOnline;
    if (this.wallet != null) {
      data['wallet'] = this.wallet.toJson();
    }
    return data;
  }
}

class Wallet {
  int id;
  int deliveryManId;
  String currentBalance;
  String cashInHand;
  String pendingWithdraw;
  String totalWithdraw;
  String createdAt;
  String updatedAt;

  Wallet(
      {this.id,
        this.deliveryManId,
        this.currentBalance,
        this.cashInHand,
        this.pendingWithdraw,
        this.totalWithdraw,
        this.createdAt,
        this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = json['delivery_man_id'];
    currentBalance = json['current_balance'];
    cashInHand = json['cash_in_hand'];
    pendingWithdraw = json['pending_withdraw'];
    totalWithdraw = json['total_withdraw'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_man_id'] = this.deliveryManId;
    data['current_balance'] = this.currentBalance;
    data['cash_in_hand'] = this.cashInHand;
    data['pending_withdraw'] = this.pendingWithdraw;
    data['total_withdraw'] = this.totalWithdraw;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
