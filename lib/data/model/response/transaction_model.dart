class TransactionModel {
  int _id;
  int _sellerId;
  int _adminId;
  double _amount;
  String _transactionNote;
  int _approved;
  String _createdAt;
  String _updatedAt;

  TransactionModel(
      {int id,
        int sellerId,
        int adminId,
        double amount,
        String transactionNote,
        int approved,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._sellerId = sellerId;
    this._adminId = adminId;
    this._amount = amount;
    this._transactionNote = transactionNote;
    this._approved = approved;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  int get sellerId => _sellerId;
  int get adminId => _adminId;
  double get amount => _amount;
  String get transactionNote => _transactionNote;
  int get approved => _approved;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sellerId = int.parse(json['seller_id'].toString());
    _adminId = json['admin_id'];
    _amount = json['amount'].toDouble();
    _transactionNote = json['transaction_note'];
    _approved = json['approved'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['seller_id'] = this._sellerId;
    data['admin_id'] = this._adminId;
    data['amount'] = this._amount;
    data['transaction_note'] = this._transactionNote;
    data['approved'] = this._approved;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}