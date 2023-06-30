class BusinessAnalyticsFilterData {
  int pending;
  int confirmed;
  int processing;
  int outForDelivery;
  int delivered;
  int canceled;
  int returned;
  int failed;

  BusinessAnalyticsFilterData(
      {this.pending,
        this.confirmed,
        this.processing,
        this.outForDelivery,
        this.delivered,
        this.canceled,
        this.returned,
        this.failed});

  BusinessAnalyticsFilterData.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    outForDelivery = json['out_for_delivery'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    returned = json['returned'];
    failed = json['failed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['out_for_delivery'] = this.outForDelivery;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['returned'] = this.returned;
    data['failed'] = this.failed;
    return data;
  }
}
