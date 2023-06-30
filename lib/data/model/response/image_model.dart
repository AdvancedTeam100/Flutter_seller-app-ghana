import 'package:image_picker/image_picker.dart';

class ImageModel {
  String type;
  String color;
  XFile image;
  String imageString;
  ColorImage colorImage;

  ImageModel({this.type, this.color, this.image, this.imageString,this.colorImage});

  ImageModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    color = json['color'];
    image = json['image'];
    imageString = json['image_string'];
    colorImage = json['color_image'] != null
        ? new ColorImage.fromJson(json['color_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['color'] = this.color;
    data['image'] = this.image;
    data['image_string'] = this.imageString;
    if (this.colorImage != null) {
      data['color_image'] = this.colorImage.toJson();
    }
    return data;
  }
}

class ColorImage {
  String color;
  String imageName;

  ColorImage({this.color, this.imageName});

  ColorImage.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    imageName = json['image_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['image_name'] = this.imageName;
    return data;
  }
}