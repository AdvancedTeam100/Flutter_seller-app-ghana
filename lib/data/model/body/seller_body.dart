class SellerBody {
  String _sMethod;
  String _fName;
  String _lName;
  String _bankName;
  String _branch;
  String _accountNo;
  String _holderName;
  String _password;
  String _image;

  SellerBody(
      {String sMethod,
        String fName,
        String lName,
        String bankName,
        String branch,
        String accountNo,
        String holderName,
        String password,
        String image}) {
    this._sMethod = sMethod;
    this._fName = fName;
    this._lName = lName;
    this._bankName = bankName;
    this._branch = branch;
    this._accountNo = accountNo;
    this._holderName = holderName;
    this._password = password;
    this._image = image;
  }

  String get sMethod => _sMethod;
  String get fName => _fName;
  String get lName => _lName;
  String get bankName => _bankName;
  String get branch => _branch;
  String get accountNo => _accountNo;
  String get holderName => _holderName;
  String get password => _password;
  String get image => _image;

  SellerBody.fromJson(Map<String, dynamic> json) {
    _sMethod = json['_method'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _bankName = json['bank_name'];
    _branch = json['branch'];
    _accountNo = json['account_no'];
    _holderName = json['holder_name:'];
    _password = json['password'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_method'] = this._sMethod;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['bank_name'] = this._bankName;
    data['branch'] = this._branch;
    data['account_no'] = this._accountNo;
    data['holder_name:'] = this._holderName;
    data['password'] = this._password;
    data['image'] = this._image;
    return data;
  }
}
