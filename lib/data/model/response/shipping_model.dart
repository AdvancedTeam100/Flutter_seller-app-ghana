class ShippingModel {
  int id;
  String title;
  String duration;
  double cost;
  int status;

  ShippingModel({this.id, this.title, this.duration, this.cost, this.status});

  ShippingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    cost = json['cost'].toDouble();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['cost'] = this.cost;
    data['status'] = this.status;
    return data;
  }
}
