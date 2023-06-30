class YearModel {
  int id;
  String year;

  YearModel({this.id, this.year});

  YearModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['month'] = this.year;
    return data;
  }
}