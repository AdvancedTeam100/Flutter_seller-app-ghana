class BusinessModel {
  int _id;
  String _title;
  String _duration;
  int _cost;

  BusinessModel(
      {int id, String title, String duration, int cost}) {
    this._id = id;
    this._title = title;
    this._duration = duration;
    this._cost = cost;
  }

  int get id => _id;
  String get title => _title;
  String get duration => _duration;
  int get cost => _cost;

  BusinessModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _duration = json['duration'];
    _cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['duration'] = this._duration;
    data['cost'] = this._cost;
    return data;
  }
}
