class UploadImage {
  List<String> productImages;
  String thumbnail;
  String metaImage;

  UploadImage({this.productImages, this.thumbnail, this.metaImage});

  UploadImage.fromJson(Map<String, dynamic> json) {
    productImages = json['product_images'].cast<String>();
    thumbnail = json['thumbnail'];
    metaImage = json['meta_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_images'] = this.productImages;
    data['thumbnail'] = this.thumbnail;
    data['meta_image'] = this.metaImage;
    return data;
  }
}