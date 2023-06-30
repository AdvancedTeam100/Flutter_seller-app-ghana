class BankInfoModel {
  int _id;
  String _name;
  String _branch;
  String _holderName;
  int _accountNo;

  BankInfoModel(
      {int id, String name, String branch, String holderName, int accountNo}) {
    this._id = id;
    this._name = name;
    this._branch = branch;
    this._holderName = holderName;
    this._accountNo = accountNo;
  }

  int get id => _id;
  String get name => _name;
  String get branch => _branch;
  String get holderName => _holderName;
  int get accountNo => _accountNo;

  BankInfoModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _branch = json['branch'];
    _holderName = json['holder_Name'];
    _accountNo = json['account_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['branch'] = this._branch;
    data['holder_Name'] = this._holderName;
    data['account_No'] = this._accountNo;
    return data;
  }
}
