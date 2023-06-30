import 'package:sixvalley_vendor_app/data/model/response/review_model.dart';

class ProductReviewModel {
  int totalSize;
  String limit;
  String offset;
  List<GroupWiseRating> groupWiseRating;
  String averageRating;
  List<ReviewModel> reviews;

  ProductReviewModel(
      {this.totalSize,
        this.limit,
        this.offset,
        this.groupWiseRating,
        this.averageRating,
        this.reviews});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['group-wise-rating'] != null) {
      groupWiseRating = <GroupWiseRating>[];
      json['group-wise-rating'].forEach((v) {
        groupWiseRating.add(new GroupWiseRating.fromJson(v));
      });
    }
    if(json['average_rating'] != null){
      averageRating = json['average_rating'].toString()??'0';
    }else{
      averageRating = "0";
    }

    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews.add(new ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.groupWiseRating != null) {
      data['group-wise-rating'] =
          this.groupWiseRating.map((v) => v.toJson()).toList();
    }
    data['average_rating'] = this.averageRating;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupWiseRating {
  int rating;
  int total;

  GroupWiseRating({this.rating, this.total});

  GroupWiseRating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['total'] = this.total;
    return data;
  }
}
