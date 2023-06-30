class MessageBody {
  int _userId;
  String _message;

  MessageBody({int sellerId, String message}) {
    this._userId = sellerId;
    this._message = message;
  }

  int get userId => _userId;
  String get message => _message;

  MessageBody.fromJson(Map<String, dynamic> json) {
    _userId = json['id'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._userId;
    data['message'] = this._message;
    return data;
  }
}
