class ShopModel {
  int id;
  String name;
  String address;
  String contact;
  String image;
  String createdAt;
  String updatedAt;
  String banner;
  double ratting;
  int rattingCount;
  int temporaryClose;
  String vacationEndDate;
  String vacationStartDate;
  int vacationStatus;



  ShopModel(
      {this.id,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.banner,
        this.ratting,
        this.rattingCount,
        this.temporaryClose,
        this.vacationEndDate,
        this.vacationStartDate,
        this.vacationStatus
      });

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    ratting = json['rating'].toDouble();
    rattingCount = json['rating_count'];
    temporaryClose = json['temporary_close'] != null? int.parse(json['temporary_close'].toString()) : 0;
    vacationEndDate = json['vacation_end_date'];
    vacationStartDate = json['vacation_start_date'];
    vacationStatus = json['vacation_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    data['rating'] = this.ratting;
    data['rating_count'] = this.rattingCount;
    data['temporary_close'] = this.temporaryClose;
    data['vacation_end_date'] = this.vacationEndDate;
    data['vacation_start_date'] = this.vacationStartDate;
    data['vacation_status'] = this.vacationStatus;

    return data;
  }
}
