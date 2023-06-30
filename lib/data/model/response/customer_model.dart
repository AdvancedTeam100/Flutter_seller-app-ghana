class CustomerModel {
  List<Customers> customers;

  CustomerModel({this.customers});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  int id;
  String fName;
  String lName;
  String phone;
  String image;
  String email;

  Customers(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
      });

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name']!=null?json['f_name']:'';
    lName = json['l_name'] != null? json['l_name']:'';
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
