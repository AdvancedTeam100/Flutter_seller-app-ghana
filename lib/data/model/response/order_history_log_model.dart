class OrderHistoryLogModel {
  String status;
  String userType;
  String createdAt;
  OrderHistoryLogModel(
      {
        this.status,
        this.userType,
        this.createdAt,
        });

  OrderHistoryLogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userType = json['user_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    return data;
  }
}
