class CollectedCashModel {
  int totalSize;
  String limit;
  String offset;
  List<CollectedCash> collectedCash;

  CollectedCashModel(
      {this.totalSize, this.limit, this.offset, this.collectedCash});

  CollectedCashModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['collected_cash'] != null) {
      collectedCash = <CollectedCash>[];
      json['collected_cash'].forEach((v) {
        collectedCash.add(new CollectedCash.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.collectedCash != null) {
      data['collected_cash'] =
          this.collectedCash.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectedCash {
  int id;
  String credit;
  String transactionType;
  String createdAt;
  String updatedAt;

  CollectedCash(
      {this.id,
        this.credit,
        this.transactionType,
        this.createdAt,
        this.updatedAt});

  CollectedCash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    credit = json['credit'];
    transactionType = json['transaction_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['credit'] = this.credit;
    data['transaction_type'] = this.transactionType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
