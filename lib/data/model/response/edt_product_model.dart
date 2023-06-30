class EditProduct {
  int id;
  String name;
  String details;
  List<Translations> translations;

  EditProduct(
      {this.id,
        this.name,
        this.details,
        this.translations});

  EditProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    if (json['translations'] != null) {
      translations = [];
      json['translations'].forEach((v) {
        translations.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    if (this.translations != null) {
      data['translations'] = this.translations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Translations {
  int id;
  String translationableType;
  int translationableId;
  String locale;
  String key;
  String value;

  Translations(
      {this.id,
        this.translationableType,
        this.translationableId,
        this.locale,
        this.key,
        this.value});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    translationableType = json['translationable_type'];
    translationableId = int.parse(json['translationable_id'].toString());
    locale = json['locale'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['translationable_type'] = this.translationableType;
    data['translationable_id'] = this.translationableId;
    data['locale'] = this.locale;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
