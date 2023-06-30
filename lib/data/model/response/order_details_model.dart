class OrderDetailsModel {
  int _id;
  int _orderId;
  int _productId;
  int _sellerId;
  String _digitalFileAfterSell;
  ProductDetails _productDetails;
  int _qty;
  double _price;
  double _tax;
  String _taxModel;
  double _discount;
  String _deliveryStatus;
  String _paymentStatus;
  String _createdAt;
  String _updatedAt;
  int _shippingMethodId;
  String _variant;
  String _variation;
  String _discountType;
  Shipping _shipping;

  OrderDetailsModel(
      {int id,
        int orderId,
        int productId,
        int sellerId,
        String digitalFileAfterSell,
        ProductDetails productDetails,
        int qty,
        double price,
        double tax,
        String taxModel,
        double discount,
        String deliveryStatus,
        String paymentStatus,
        String createdAt,
        String updatedAt,
        int shippingMethodId,
        String variant,
        String variation,
        String discountType,
        Shipping shipping}) {
    this._id = id;
    this._orderId = orderId;
    this._productId = productId;
    this._sellerId = sellerId;
    this._digitalFileAfterSell = digitalFileAfterSell;
    this._productDetails = productDetails;
    this._qty = qty;
    this._price = price;
    this._tax = tax;
    this._taxModel = taxModel;
    this._discount = discount;
    this._deliveryStatus = deliveryStatus;
    this._paymentStatus = paymentStatus;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._shippingMethodId = shippingMethodId;
    this._variant = variant;
    this._variation = variation;
    this._discountType = discountType;
    this._shipping = shipping;
  }

  int get id => _id;
  // ignore: unnecessary_getters_setters
  int get orderId => _orderId;

  // ignore: unnecessary_getters_setters
  set orderId(int orderId) => _orderId = orderId;
  int get productId => _productId;
  int get sellerId => _sellerId;
  String get digitalFileAfterSell  => _digitalFileAfterSell;
  ProductDetails get productDetails => _productDetails;
  int get qty => _qty;
  double get price => _price;
  double get tax => _tax;
  String get taxModel => _taxModel;
  double get discount => _discount;
  // ignore: unnecessary_getters_setters
  String get deliveryStatus => _deliveryStatus;
  // ignore: unnecessary_getters_setters
  set deliveryStatus(String deliveryStatus) => _deliveryStatus = deliveryStatus;
  String get paymentStatus => _paymentStatus;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get shippingMethodId => _shippingMethodId;
  String get variant => _variant;
  String get variation => _variation;
  String get discountType => _discountType;
  Shipping get shipping => _shipping;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _sellerId = json['seller_id'];
    _digitalFileAfterSell = json['digital_file_after_sell'];
    _productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    _qty = json['qty'];
    if(json['price']!=null){
      _price = json['price'].toDouble();
    }

    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _discount = json['discount'].toDouble();
    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shippingMethodId = json['shipping_method_id'];
    _variant = json['variant'];
    _variation = json['variation'];
    _discountType = json['discount_type'];
    _shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['product_id'] = this._productId;
    data['seller_id'] = this._sellerId;
    data['digital_file_after_sell'] = this._digitalFileAfterSell;
    if (this._productDetails != null) {
      data['product_details'] = this._productDetails.toJson();
    }
    data['qty'] = this._qty;
    data['price'] = this._price;
    data['tax'] = this._tax;
    data['tax_model'] = this._taxModel;
    data['discount'] = this._discount;
    data['delivery_status'] = this._deliveryStatus;
    data['payment_status'] = this._paymentStatus;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['shipping_method_id'] = this._shippingMethodId;
    data['variant'] = this._variant;
    data['variation'] = this._variation;
    data['discount_type'] = this._discountType;
    if (this._shipping != null) {
      data['shipping'] = this._shipping.toJson();
    }
    return data;
  }
}

class ProductDetails {
  int _id;
  String _addedBy;
  int _userId;
  String _name;
  String _productType;
  List<CategoryIds> _categoryIds;
  int _brandId;
  String _unit;
  int _minQty;
  List<String> _images;
  String _thumbnail;
  List<Colores> _colors;
  List<ChoiceOptions> _choiceOptions;
  List<Variation> _variation;
  double _unitPrice;
  double _purchasePrice;
  double _tax;
  String _taxModel;
  String _taxType;
  double _discount;
  String _discountType;
  int _currentStock;
  String _details;
  int _freeShipping;
  String _createdAt;
  String _updatedAt;
  String _digitalProductType;
  String _digitalFileReady;

  ProductDetails(
      {int id,
        String addedBy,
        int userId,
        String name,
        String productType,
        List<CategoryIds> categoryIds,
        int brandId,
        String unit,
        int minQty,
        List<String> images,
        String thumbnail,
        List<Colores> colors,
        List<String> attributes,
        List<ChoiceOptions> choiceOptions,
        List<Variation> variation,
        double unitPrice,
        double purchasePrice,
        double tax,
        String taxModel,
        String taxType,
        double discount,
        String discountType,
        int currentStock,
        String details,
        String createdAt,
        String updatedAt,
        String digitalProductType,
        String digitalFileReady,
      }) {
    this._id = id;
    this._addedBy = addedBy;
    this._userId = userId;
    this._name = name;
    this._productType = productType;
    this._categoryIds = categoryIds;
    this._brandId = brandId;
    this._unit = unit;
    this._minQty = minQty;
    this._images = images;
    this._thumbnail = thumbnail;
    this._colors = colors;
    this._choiceOptions = choiceOptions;
    this._variation = variation;
    this._unitPrice = unitPrice;
    this._purchasePrice = purchasePrice;
    this._tax = tax;
    this._taxModel = taxModel;
    this._taxType = taxType;
    this._discount = discount;
    this._discountType = discountType;
    this._currentStock = currentStock;
    this._details = details;
    this._freeShipping = freeShipping;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    if (digitalProductType != null) {
      this._digitalProductType = digitalProductType;
    }
    if (digitalFileReady != null) {
      this._digitalFileReady = digitalFileReady;
    }
  }

  int get id => _id;
  String get addedBy => _addedBy;
  int get userId => _userId;
  String get name => _name;
  String get productType => _productType;
  List<CategoryIds> get categoryIds => _categoryIds;
  int get brandId => _brandId;
  String get unit => _unit;
  int get minQty => _minQty;
  List<String> get images => _images;
  String get thumbnail => _thumbnail;
  List<Colores> get colors => _colors;
  List<ChoiceOptions> get choiceOptions => _choiceOptions;
  List<Variation> get variation => _variation;
  double get unitPrice => _unitPrice;
  double get purchasePrice => _purchasePrice;
  double get tax => _tax;
  String get taxModel => _taxModel;
  String get taxType => _taxType;
  double get discount => _discount;
  String get discountType => _discountType;
  int get currentStock => _currentStock;
  String get details => _details;
  int get freeShipping => _freeShipping;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get digitalProductType => _digitalProductType;
  String get digitalFileReady => _digitalFileReady;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _name = json['name'];
    _productType = json['product_type'];
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds.add(new CategoryIds.fromJson(v));
      });
    }
    _brandId = json['brand_id'];
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _images = json['images'].cast<String>();
    _thumbnail = json['thumbnail'];
    if (json['colors_formatted'] != null) {
      _colors = [];
      json['colors_formatted'].forEach((v) {
        _colors.add(new Colores.fromJson(v));
      });
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation.add(new Variation.fromJson(v));
      });
    }
    _unitPrice = json['unit_price'].toDouble();
    _purchasePrice = json['purchase_price'].toDouble();
    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _taxType = json['tax_type'];
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    _details = json['details'];
    _freeShipping = json['free_shipping'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if(json['digital_product_type']!=null){
      _digitalProductType = json['digital_product_type'];
    }
    if(json['digital_file_ready']!=null){
      _digitalFileReady = json['digital_file_ready'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['added_by'] = this._addedBy;
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['product_type'] = this.productType;
    if (this._categoryIds != null) {
      data['category_ids'] = this._categoryIds.map((v) => v.toJson()).toList();
    }
    data['brand_id'] = this._brandId;
    data['unit'] = this._unit;
    data['min_qty'] = this._minQty;
    data['images'] = this._images;
    data['thumbnail'] = this._thumbnail;
    if (this._colors != null) {
      data['colors_formatted'] = this._colors.map((v) => v.toJson()).toList();
    }
    if (this._choiceOptions != null) {
      data['choice_options'] =
          this._choiceOptions.map((v) => v.toJson()).toList();
    }
    if (this._variation != null) {
      data['variation'] = this._variation.map((v) => v.toJson()).toList();
    }
    data['unit_price'] = this._unitPrice;
    data['purchase_price'] = this._purchasePrice;
    data['tax'] = this._tax;
    data['tax_model'] = this._taxModel;
    data['tax_type'] = this._taxType;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['current_stock'] = this._currentStock;
    data['details'] = this._details;
    data['free_shipping'] = this._freeShipping;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['digital_product_type'] = this.digitalProductType;
    data['digital_file_ready'] = this.digitalFileReady;
    return data;
  }
}

class CategoryIds {
  String _id;
  int _position;

  CategoryIds({String id, int position}) {
    this._id = id;
    this._position = position;
  }

  String get id => _id;
  int get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['position'] = this._position;
    return data;
  }
}

class Colores {
  String _name;
  String _code;

  Colores({String name, String code}) {
    this._name = name;
    this._code = code;
  }

  String get name => _name;
  String get code => _code;

  Colores.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['code'] = this._code;
    return data;
  }
}

class ChoiceOptions {
  String _name;
  String _title;
  List<String> _options;

  ChoiceOptions({String name, String title, List<String> options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String get name => _name;
  String get title => _title;
  List<String> get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class Variation {
  String _type;
  double _price;
  String _sku;
  int _qty;

  Variation({String type, double price, String sku, int qty}) {
    this._type = type;
    this._price = price;
    this._sku = sku;
    this._qty = qty;
  }

  String get type => _type;
  double get price => _price;
  String get sku => _sku;
  int get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['price'] = this._price;
    data['sku'] = this._sku;
    data['qty'] = this._qty;
    return data;
  }
}

class Shipping {
  int _id;
  int _creatorId;
  String _creatorType;
  String _title;
  int _cost;
  String _duration;
  int _status;
  String _createdAt;
  String _updatedAt;

  Shipping(
      {int id,
        int creatorId,
        String creatorType,
        String title,
        int cost,
        String duration,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._creatorId = creatorId;
    this._creatorType = creatorType;
    this._title = title;
    this._cost = cost;
    this._duration = duration;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  int get creatorId => _creatorId;
  String get creatorType => _creatorType;
  String get title => _title;
  int get cost => _cost;
  String get duration => _duration;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Shipping.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _creatorId = json['creator_id'];
    _creatorType = json['creator_type'];
    _title = json['title'];
    _cost = json['cost'];
    _duration = json['duration'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['creator_id'] = this._creatorId;
    data['creator_type'] = this._creatorType;
    data['title'] = this._title;
    data['cost'] = this._cost;
    data['duration'] = this._duration;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
